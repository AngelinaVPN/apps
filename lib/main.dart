import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flclashx/plugins/app.dart';
import 'package:flclashx/plugins/tile.dart';
import 'package:flclashx/plugins/vpn.dart';
import 'package:flclashx/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'application.dart';
import 'clash/core.dart';
import 'clash/lib.dart';
import 'common/common.dart';
import 'models/models.dart';

Future<void> main() async {
  globalState.isService = false;
  WidgetsFlutterBinding.ensureInitialized();
  
  // Enable Skia graphics for better performance on desktop
  if (Platform.isWindows || Platform.isLinux) {
    DartPluginRegistrant.ensureInitialized();
  }
  
  final version = await system.version;
  await clashCore.preload();
  await globalState.initApp(version);
  await android?.init();
  await window?.init(version);
  HttpOverrides.global = FlClashHttpOverrides();
  runApp(const ProviderScope(
    child: Application(),
  ));
}

@pragma('vm:entry-point')
Future<void> _service(List<String> flags) async {
  globalState.isService = true;
  WidgetsFlutterBinding.ensureInitialized();
  final quickStart = flags.contains("quick");
  final clashLibHandler = ClashLibHandler();
  await globalState.init();

  tile?.addListener(
    _TileListenerWithService(
      onStop: () async {
        await app?.tip(appLocalizations.stopVpn);
        clashLibHandler.stopListener();
        await vpn?.stop();
        exit(0);
      },
    ),
  );

  vpn?.handleGetStartForegroundParams = () {
    final traffic = clashLibHandler.getTraffic();
    return json.encode({
      "title": clashLibHandler.getCurrentProfileName(),
      "content": "$traffic"
    });
  };

  vpn?.addListener(
    _VpnListenerWithService(
      onDnsChanged: (dns) {
        print("handle dns $dns");
        clashLibHandler.updateDns(dns);
      },
    ),
  );
  if (!quickStart) {
    _handleMainIpc(clashLibHandler);
  } else {
    commonPrint.log("quick start");
    await ClashCore.initGeo();
    app?.tip(appLocalizations.startVpn);
    final homeDirPath = await appPath.homeDirPath;
    final version = await system.version;
    final clashConfig = globalState.config.patchClashConfig.copyWith.tun(
      enable: false,
    );
    unawaited(Future(() async {
      final profileId = globalState.config.currentProfileId;
      if (profileId == null) {
        return;
      }
      final params = await globalState.getSetupParams(
        pathConfig: clashConfig,
      );
      final res = await clashLibHandler.quickStart(
        InitParams(
          homeDir: homeDirPath,
          version: version,
        ),
        params,
        globalState.getCoreState(),
      );
      debugPrint(res);
      if (res.isNotEmpty) {
        await vpn?.stop();
        exit(0);
      }
      await vpn?.start(
        clashLibHandler.getAndroidVpnOptions(),
      );
      clashLibHandler.startListener();
    }));
  }
}

void _handleMainIpc(ClashLibHandler clashLibHandler) {
  final sendPort = IsolateNameServer.lookupPortByName(mainIsolate);
  if (sendPort == null) {
    return;
  }
  final serviceReceiverPort = ReceivePort();
  serviceReceiverPort.listen((message) async {
    final res = await clashLibHandler.invokeAction(message);
    sendPort.send(res);
  });
  sendPort.send(serviceReceiverPort.sendPort);
  final messageReceiverPort = ReceivePort();
  clashLibHandler.attachMessagePort(
    messageReceiverPort.sendPort.nativePort,
  );
  messageReceiverPort.listen(sendPort.send);
}

@immutable
class _TileListenerWithService with TileListener {

  const _TileListenerWithService({
    required Function() onStop,
  }) : _onStop = onStop;
  final Function() _onStop;

  @override
  void onStop() {
    _onStop();
  }
}

@immutable
class _VpnListenerWithService with VpnListener {

  const _VpnListenerWithService({
    required Function(String dns) onDnsChanged,
  }) : _onDnsChanged = onDnsChanged;
  final Function(String dns) _onDnsChanged;

  @override
  void onDnsChanged(String dns) {
    super.onDnsChanged(dns);
    _onDnsChanged(dns);
  }
}

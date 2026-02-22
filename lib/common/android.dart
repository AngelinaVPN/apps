import 'dart:io';

import 'package:angelinavpn/plugins/app.dart';
import 'package:angelinavpn/state.dart';

class Android {
  Future<void> init() async {
    app?.onExit = () async {
      await globalState.appController.savePreferences();
    };
  }
}

final android = Platform.isAndroid ? Android() : null;

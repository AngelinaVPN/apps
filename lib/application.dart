import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:angelinavpn/clash/clash.dart';
import 'package:angelinavpn/common/common.dart';
import 'package:angelinavpn/l10n/l10n.dart';
import 'package:angelinavpn/manager/hotkey_manager.dart';
import 'package:angelinavpn/manager/manager.dart';
import 'package:angelinavpn/plugins/app.dart';
import 'package:angelinavpn/providers/providers.dart';
import 'package:angelinavpn/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controller.dart';
import 'pages/pages.dart';
import 'views/angelina/angelina_view.dart';

class Application extends ConsumerStatefulWidget {
  const Application({
    super.key,
  });

  @override
  ConsumerState<Application> createState() => ApplicationState();
}

class ApplicationState extends ConsumerState<Application> {
  Timer? _autoUpdateGroupTaskTimer;
  Timer? _autoUpdateProfilesTaskTimer;

  final _pageTransitionsTheme = const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: CommonPageTransitionsBuilder(),
      TargetPlatform.windows: CommonPageTransitionsBuilder(),
      TargetPlatform.linux: CommonPageTransitionsBuilder(),
      TargetPlatform.macOS: CommonPageTransitionsBuilder(),
    },
  );

  ColorScheme _getAppColorScheme({
    required Brightness brightness,
    int? primaryColor,
  }) =>
      ref.read(genColorSchemeProvider(brightness));

  @override
  void initState() {
    super.initState();

    if (Platform.isWindows) {
      windows?.enableDarkModeForApp();
    }

    _autoUpdateGroupTask();
    _autoUpdateProfilesTask();
    globalState.appController = AppController(context, ref);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final currentContext = globalState.navigatorKey.currentContext;
      if (currentContext != null) {
        globalState.appController = AppController(currentContext, ref);
      }
      await globalState.appController.init();
      globalState.appController.initLink();
      app?.initShortcuts();
    });
  }

  void _autoUpdateGroupTask() {
    _autoUpdateGroupTaskTimer = Timer(const Duration(milliseconds: 20000), () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        globalState.appController.updateGroupsDebounce();
        _autoUpdateGroupTask();
      });
    });
  }

  void _autoUpdateProfilesTask() {
    _autoUpdateProfilesTaskTimer = Timer(const Duration(minutes: 20), () async {
      await globalState.appController.autoUpdateProfiles();
      _autoUpdateProfilesTask();
    });
  }

  Widget _buildPlatformState(Widget child) {
    if (system.isDesktop) {
      return WindowManager(
        child: TrayManager(
          child: HotKeyManager(
            child: ProxyManager(
              child: child,
            ),
          ),
        ),
      );
    }
    return AndroidManager(
      child: TileManager(
        child: child,
      ),
    );
  }

  Widget _buildState(Widget child) => AppStateManager(
        child: ClashManager(
          child: ConnectivityManager(
            onConnectivityChanged: (results) async {
              if (!results.contains(ConnectivityResult.vpn)) {
                clashCore.closeConnections();
              }
              globalState.appController.updateLocalIp();
              globalState.appController.addCheckIpNumDebounce();
            },
            child: child,
          ),
        ),
      );

  Widget _buildPlatformApp(Widget child) {
    if (system.isDesktop) {
      return WindowHeaderContainer(
        child: child,
      );
    }
    return VpnManager(
      child: child,
    );
  }

  Widget _buildApp(Widget child) => MessageManager(
        child: ThemeManager(
          child: child,
        ),
      );

  @override
  Widget build(BuildContext context) => _buildPlatformState(
        _buildState(
          Consumer(
            builder: (_, ref, child) {
              final locale =
                  ref.watch(appSettingProvider.select((state) => state.locale));
              final themeProps = ref.watch(themeSettingProvider);
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                navigatorKey: globalState.navigatorKey,
                checkerboardRasterCacheImages: false,
                checkerboardOffscreenLayers: false,
                showPerformanceOverlay: false,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate
                ],
                builder: (context, child) {
                  final Widget app = AppEnvManager(
                    child: _buildPlatformApp(
                      _buildApp(child!),
                    ),
                  );

                  if (Platform.isMacOS) {
                    final mediaQuery = MediaQuery.of(context);
                    return MediaQuery(
                      data: mediaQuery.copyWith(
                        textScaler: const TextScaler.linear(1.08),
                      ),
                      child: app,
                    );
                  }

                  return app;
                },
                scrollBehavior: BaseScrollBehavior(),
                title: appName,
                locale: utils.getLocaleForString(locale),
                supportedLocales: AppLocalizations.delegate.supportedLocales,
                themeMode: themeProps.themeMode,
                theme: ThemeData(
                  useMaterial3: true,
                  pageTransitionsTheme: _pageTransitionsTheme,
                  fontFamily: 'JetBrainsMono',
                  colorScheme: _getAppColorScheme(
                    brightness: Brightness.light,
                    primaryColor: themeProps.primaryColor,
                  ),
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                darkTheme: ThemeData(
                  useMaterial3: true,
                  pageTransitionsTheme: _pageTransitionsTheme,
                  fontFamily: 'JetBrainsMono',
                  colorScheme: _getAppColorScheme(
                    brightness: Brightness.dark,
                    primaryColor: themeProps.primaryColor,
                  ).toPureBlack(true).copyWith(
                    surface: const Color(0xFF0A0A0A),
                    surfaceContainerLowest: const Color(0xFF050505),
                    surfaceContainerLow: const Color(0xFF0D0D0D),
                    surfaceContainer: const Color(0xFF111111),
                    surfaceContainerHigh: const Color(0xFF151515),
                    surfaceContainerHighest: const Color(0xFF1A1A1A),
                    onSurface: Colors.white,
                    primary: const Color(0xFF00E675),
                    onPrimary: Colors.black,
                    primaryContainer: const Color(0xFF00E675),
                    onPrimaryContainer: Colors.black,
                    secondary: const Color(0xFF69F0AD),
                    onSecondary: Colors.black,
                    secondaryContainer: const Color(0xFF1A1A1A),
                    onSecondaryContainer: Colors.white,
                    outline: const Color(0xFF1E1E1E),
                    outlineVariant: const Color(0xFF131313),
                  ),
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  appBarTheme: const AppBarTheme(
                    backgroundColor: Color(0xFF0A0A0A),
                    foregroundColor: Colors.white,
                    surfaceTintColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                    titleTextStyle: TextStyle(
                      fontFamily: 'JetBrainsMono',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 2.0,
                    ),
                  ),
                  navigationBarTheme: NavigationBarThemeData(
                    backgroundColor: const Color(0xFF0D0D0D),
                    indicatorColor: const Color(0xFF1A2E1A),
                    surfaceTintColor: Colors.transparent,
                    labelTextStyle: WidgetStateProperty.resolveWith((states) =>
                      TextStyle(
                        fontFamily: 'JetBrainsMono',
                        fontSize: 10,
                        letterSpacing: 1.2,
                        color: states.contains(WidgetState.selected)
                            ? const Color(0xFF00E675)
                            : Colors.white38,
                      )),
                    iconTheme: WidgetStateProperty.resolveWith((states) =>
                      IconThemeData(
                        color: states.contains(WidgetState.selected)
                            ? const Color(0xFF00E675)
                            : Colors.white38,
                        size: 22,
                      )),
                  ),
                  navigationRailTheme: const NavigationRailThemeData(
                    backgroundColor: Color(0xFF0D0D0D),
                    selectedIconTheme: IconThemeData(color: Color(0xFF00E675), size: 22),
                    unselectedIconTheme: IconThemeData(color: Colors.white38, size: 22),
                    indicatorColor: Color(0xFF1A2E1A),
                    selectedLabelTextStyle: TextStyle(
                      fontFamily: 'JetBrainsMono',
                      fontSize: 10,
                      color: Color(0xFF00E675),
                      letterSpacing: 1.2,
                    ),
                    unselectedLabelTextStyle: TextStyle(
                      fontFamily: 'JetBrainsMono',
                      fontSize: 10,
                      color: Colors.white38,
                      letterSpacing: 1.2,
                    ),
                  ),
                  dividerTheme: const DividerThemeData(
                    color: Color(0xFF1A1A1A),
                    thickness: 1,
                    space: 1,
                  ),
                  cardTheme: const CardThemeData(
                    color: Color(0xFF111111),
                    surfaceTintColor: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      side: BorderSide(color: Color(0xFF1E1E1E)),
                    ),
                  ),
                  inputDecorationTheme: InputDecorationTheme(
                    filled: true,
                    fillColor: const Color(0xFF111111),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Color(0xFF1E1E1E)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Color(0xFF1E1E1E)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Color(0xFF00E675), width: 1.5),
                    ),
                    hintStyle: const TextStyle(color: Colors.white24, fontFamily: 'JetBrainsMono'),
                    labelStyle: const TextStyle(color: Colors.white54, fontFamily: 'JetBrainsMono'),
                  ),
                  listTileTheme: const ListTileThemeData(
                    tileColor: Colors.transparent,
                    textColor: Colors.white,
                    iconColor: Color(0xFF00E675),
                  ),
                  iconTheme: const IconThemeData(
                    color: Colors.white70,
                    size: 20,
                  ),
                  iconButtonTheme: IconButtonThemeData(
                    style: IconButton.styleFrom(
                      foregroundColor: Colors.white70,
                    ),
                  ),
                  floatingActionButtonTheme: const FloatingActionButtonThemeData(
                    backgroundColor: Color(0xFF00E675),
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                  chipTheme: ChipThemeData(
                    backgroundColor: const Color(0xFF111111),
                    side: const BorderSide(color: Color(0xFF1E1E1E)),
                    labelStyle: const TextStyle(
                      fontFamily: 'JetBrainsMono',
                      fontSize: 11,
                      color: Colors.white70,
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  switchTheme: SwitchThemeData(
                    thumbColor: WidgetStateProperty.resolveWith((states) =>
                      states.contains(WidgetState.selected)
                          ? const Color(0xFF00E675)
                          : Colors.white38),
                    trackColor: WidgetStateProperty.resolveWith((states) =>
                      states.contains(WidgetState.selected)
                          ? const Color(0xFF1A3D1A)
                          : const Color(0xFF1A1A1A)),
                    trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
                  ),
                  progressIndicatorTheme: const ProgressIndicatorThemeData(
                    color: Color(0xFF00E675),
                    linearTrackColor: Color(0xFF1A1A1A),
                    circularTrackColor: Color(0xFF1A1A1A),
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF00E675),
                      textStyle: const TextStyle(
                        fontFamily: 'JetBrainsMono',
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  filledButtonTheme: FilledButtonThemeData(
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF00E675),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      textStyle: const TextStyle(
                        fontFamily: 'JetBrainsMono',
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  snackBarTheme: SnackBarThemeData(
                    backgroundColor: const Color(0xFF111111),
                    contentTextStyle: const TextStyle(
                      fontFamily: 'JetBrainsMono',
                      color: Colors.white,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                      side: const BorderSide(color: Color(0xFF1E1E1E)),
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                  dialogTheme: DialogThemeData(
                    backgroundColor: const Color(0xFF0D0D0D),
                    surfaceTintColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Color(0xFF1E1E1E)),
                    ),
                    titleTextStyle: const TextStyle(
                      fontFamily: 'JetBrainsMono',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  popupMenuTheme: PopupMenuThemeData(
                    color: const Color(0xFF111111),
                    surfaceTintColor: Colors.transparent,
                    elevation: 4,
                    shadowColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                      side: const BorderSide(color: Color(0xFF1E1E1E)),
                    ),
                    textStyle: const TextStyle(
                      fontFamily: 'JetBrainsMono',
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  tooltipTheme: TooltipThemeData(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: const Color(0xFF1E1E1E)),
                    ),
                    textStyle: const TextStyle(
                      fontFamily: 'JetBrainsMono',
                      fontSize: 11,
                      color: Colors.white70,
                    ),
                  ),
                  tabBarTheme: const TabBarThemeData(
                    labelColor: Color(0xFF00E675),
                    unselectedLabelColor: Colors.white38,
                    indicatorColor: Color(0xFF00E675),
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Color(0xFF1A1A1A),
                    labelStyle: TextStyle(
                      fontFamily: 'JetBrainsMono',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontFamily: 'JetBrainsMono',
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.2,
                    ),
                  ),
                  scrollbarTheme: ScrollbarThemeData(
                    thumbColor: WidgetStateProperty.all(const Color(0xFF2A2A2A)),
                    trackColor: WidgetStateProperty.all(Colors.transparent),
                    radius: const Radius.circular(2),
                    thickness: WidgetStateProperty.all(3),
                  ),
                ),
                home: child,
              );
            },
            child: const AngelinaView(),
          ),
        ),
      );

  @override
  Future<void> dispose() async {
    linkManager.destroy();
    _autoUpdateGroupTaskTimer?.cancel();
    _autoUpdateProfilesTaskTimer?.cancel();
    await clashCore.destroy();
    await globalState.appController.savePreferences();
    await globalState.appController.handleExit();
    super.dispose();
  }
}

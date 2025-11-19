import 'dart:io';

import 'package:flclashx/common/common.dart';
import 'package:flclashx/providers/config.dart';
import 'package:flclashx/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class OverrideProviderSettingsItem extends ConsumerWidget {
  const OverrideProviderSettingsItem({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final overrideProviderSettings = ref.watch(
      appSettingProvider.select((state) => state.overrideProviderSettings),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListItem.switchItem(
          title: Text(appLocalizations.overrideProviderSettings),
          subtitle: Text(appLocalizations.overrideProviderSettingsDesc),
          delegate: SwitchDelegate(
            value: overrideProviderSettings,
            onChanged: (value) {
              ref.read(appSettingProvider.notifier).updateState(
                    (state) => state.copyWith(
                      overrideProviderSettings: value,
                    ),
                  );
            },
          ),
        ),
        if (!overrideProviderSettings)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    appLocalizations.managedByProvider,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class CloseConnectionsItem extends ConsumerWidget {
  const CloseConnectionsItem({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final closeConnections = ref.watch(
      appSettingProvider.select((state) => state.closeConnections),
    );
    return ListItem.switchItem(
      title: Text(appLocalizations.autoCloseConnections),
      subtitle: Text(appLocalizations.autoCloseConnectionsDesc),
      delegate: SwitchDelegate(
        value: closeConnections,
        onChanged: (value) async {
          ref.read(appSettingProvider.notifier).updateState(
                (state) => state.copyWith(
                  closeConnections: value,
                ),
              );
        },
      ),
    );
  }
}

class UsageItem extends ConsumerWidget {
  const UsageItem({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final onlyStatisticsProxy = ref.watch(
      appSettingProvider.select((state) => state.onlyStatisticsProxy),
    );
    return ListItem.switchItem(
      title: Text(appLocalizations.onlyStatisticsProxy),
      subtitle: Text(appLocalizations.onlyStatisticsProxyDesc),
      delegate: SwitchDelegate(
        value: onlyStatisticsProxy,
        onChanged: (bool value) async {
          ref.read(appSettingProvider.notifier).updateState(
                (state) => state.copyWith(
                  onlyStatisticsProxy: value,
                ),
              );
        },
      ),
    );
  }
}

class MinimizeItem extends ConsumerWidget {
  const MinimizeItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final minimizeOnExit = ref.watch(
      appSettingProvider.select((state) => state.minimizeOnExit),
    );
    final overrideProviderSettings = ref.watch(
      appSettingProvider.select((state) => state.overrideProviderSettings),
    );
    final isEnabled = overrideProviderSettings;
    return Opacity(
      opacity: isEnabled ? 1.0 : 0.5,
      child: ListItem.switchItem(
        title: Text(appLocalizations.minimizeOnExit),
        subtitle: Text(appLocalizations.minimizeOnExitDesc),
        delegate: SwitchDelegate(
          value: minimizeOnExit,
          onChanged: isEnabled ? (bool value) {
            ref.read(appSettingProvider.notifier).updateState(
                  (state) => state.copyWith(
                    minimizeOnExit: value,
                  ),
                );
          } : null,
        ),
      ),
    );
  }
}

class AutoLaunchItem extends ConsumerWidget {
  const AutoLaunchItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final autoLaunch = ref.watch(
      appSettingProvider.select((state) => state.autoLaunch),
    );
    final overrideProviderSettings = ref.watch(
      appSettingProvider.select((state) => state.overrideProviderSettings),
    );
    final isEnabled = overrideProviderSettings;
    return Opacity(
      opacity: isEnabled ? 1.0 : 0.5,
      child: ListItem.switchItem(
        title: Text(appLocalizations.autoLaunch),
        subtitle: Text(appLocalizations.autoLaunchDesc),
        delegate: SwitchDelegate(
          value: autoLaunch,
          onChanged: isEnabled ? (bool value) {
            ref.read(appSettingProvider.notifier).updateState(
                  (state) => state.copyWith(
                    autoLaunch: value,
                  ),
                );
          } : null,
        ),
      ),
    );
  }
}

class SilentLaunchItem extends ConsumerWidget {
  const SilentLaunchItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final silentLaunch = ref.watch(
      appSettingProvider.select((state) => state.silentLaunch),
    );
    final overrideProviderSettings = ref.watch(
      appSettingProvider.select((state) => state.overrideProviderSettings),
    );
    final isEnabled = overrideProviderSettings;
    return Opacity(
      opacity: isEnabled ? 1.0 : 0.5,
      child: ListItem.switchItem(
        title: Text(appLocalizations.silentLaunch),
        subtitle: Text(appLocalizations.silentLaunchDesc),
        delegate: SwitchDelegate(
          value: silentLaunch,
          onChanged: isEnabled ? (bool value) {
            ref.read(appSettingProvider.notifier).updateState(
                  (state) => state.copyWith(
                    silentLaunch: value,
                  ),
                );
          } : null,
        ),
      ),
    );
  }
}

class AutoRunItem extends ConsumerWidget {
  const AutoRunItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final autoRun = ref.watch(
      appSettingProvider.select((state) => state.autoRun),
    );
    final overrideProviderSettings = ref.watch(
      appSettingProvider.select((state) => state.overrideProviderSettings),
    );
    final isEnabled = overrideProviderSettings;
    return Opacity(
      opacity: isEnabled ? 1.0 : 0.5,
      child: ListItem.switchItem(
        title: Text(appLocalizations.autoRun),
        subtitle: Text(appLocalizations.autoRunDesc),
        delegate: SwitchDelegate(
          value: autoRun,
          onChanged: isEnabled ? (bool value) {
            ref.read(appSettingProvider.notifier).updateState(
                  (state) => state.copyWith(
                    autoRun: value,
                  ),
                );
          } : null,
        ),
      ),
    );
  }
}

class HiddenItem extends ConsumerWidget {
  const HiddenItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hidden = ref.watch(
      appSettingProvider.select((state) => state.hidden),
    );
    return ListItem.switchItem(
      title: Text(appLocalizations.exclude),
      subtitle: Text(appLocalizations.excludeDesc),
      delegate: SwitchDelegate(
        value: hidden,
        onChanged: (value) {
          ref.read(appSettingProvider.notifier).updateState(
                (state) => state.copyWith(
                  hidden: value,
                ),
              );
        },
      ),
    );
  }
}

class AnimateTabItem extends ConsumerWidget {
  const AnimateTabItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAnimateToPage = ref.watch(
      appSettingProvider.select((state) => state.isAnimateToPage),
    );
    return ListItem.switchItem(
      title: Text(appLocalizations.tabAnimation),
      subtitle: Text(appLocalizations.tabAnimationDesc),
      delegate: SwitchDelegate(
        value: isAnimateToPage,
        onChanged: (value) {
          ref.read(appSettingProvider.notifier).updateState(
                (state) => state.copyWith(
                  isAnimateToPage: value,
                ),
              );
        },
      ),
    );
  }
}

class OpenLogsItem extends ConsumerWidget {
  const OpenLogsItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final openLogs = ref.watch(
      appSettingProvider.select((state) => state.openLogs),
    );
    return ListItem.switchItem(
      title: Text(appLocalizations.logcat),
      subtitle: Text(appLocalizations.logcatDesc),
      delegate: SwitchDelegate(
        value: openLogs,
        onChanged: (bool value) {
          ref.read(appSettingProvider.notifier).updateState(
                (state) => state.copyWith(
                  openLogs: value,
                ),
              );
        },
      ),
    );
  }
}

class AutoCheckUpdateItem extends ConsumerWidget {
  const AutoCheckUpdateItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final autoCheckUpdate = ref.watch(
      appSettingProvider.select((state) => state.autoCheckUpdate),
    );
    final overrideProviderSettings = ref.watch(
      appSettingProvider.select((state) => state.overrideProviderSettings),
    );
    final isEnabled = overrideProviderSettings;
    return Opacity(
      opacity: isEnabled ? 1.0 : 0.5,
      child: ListItem.switchItem(
        title: Text(appLocalizations.autoCheckUpdate),
        subtitle: Text(appLocalizations.autoCheckUpdateDesc),
        delegate: SwitchDelegate(
          value: autoCheckUpdate,
          onChanged: isEnabled ? (bool value) {
            ref.read(appSettingProvider.notifier).updateState(
                  (state) => state.copyWith(
                    autoCheckUpdate: value,
                  ),
                );
          } : null,
        ),
      ),
    );
  }
}

class ApplicationSettingView extends StatelessWidget {
  const ApplicationSettingView({super.key});

  String getLocaleString(Locale? locale) {
    if (locale == null) return appLocalizations.defaultText;
    return Intl.message(locale.toString());
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [
      OverrideProviderSettingsItem(),
      MinimizeItem(),
      if (system.isDesktop) ...[
        AutoLaunchItem(),
        SilentLaunchItem(),
      ],
      AutoRunItem(),
      if (Platform.isAndroid) ...[
        HiddenItem(),
      ],
      AnimateTabItem(),
      OpenLogsItem(),
      CloseConnectionsItem(),
      UsageItem(),
      AutoCheckUpdateItem(),
    ];
    return ListView.separated(
      itemBuilder: (_, index) {
        final item = items[index];
        return item;
      },
      separatorBuilder: (_, __) {
        return const Divider(
          height: 0,
        );
      },
      itemCount: items.length,
    );
  }
}

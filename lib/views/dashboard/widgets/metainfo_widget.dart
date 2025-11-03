import 'package:flclashx/common/common.dart';
import 'package:flclashx/models/models.dart';
import 'package:flclashx/providers/providers.dart';
import 'package:flclashx/state.dart';
import 'package:flclashx/views/profiles/add_profile.dart';
import 'package:flclashx/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class MetainfoWidget extends ConsumerWidget {
  const MetainfoWidget({super.key});

  // Функция для склонения слова "день"
  String _getDaysDeclension(int days) {
    if (days % 100 >= 11 && days % 100 <= 19) {
      return appLocalizations.days; // дней
    }
    switch (days % 10) {
      case 1:
        return appLocalizations.day; // день
      case 2:
      case 3:
      case 4:
        return appLocalizations.daysGenitive; // дня
      default:
        return appLocalizations.days; // дней
    }
  }

  // Функция для склонения слова "час"
  String _getHoursDeclension(int hours) {
    if (hours % 100 >= 11 && hours % 100 <= 19) {
      return appLocalizations.hoursGenitive; // часов
    }
    switch (hours % 10) {
      case 1:
        return appLocalizations.hour; // час
      case 2:
      case 3:
      case 4:
        return appLocalizations.hoursPlural; // часа
      default:
        return appLocalizations.hoursGenitive; // часов
    }
  }

  // Функция для склонения слова "остался/осталось"
  String _getRemainingDeclension(int value) {
    // "остался" для единственного числа (1, 21, 31 и т.д., кроме 11)
    if (value % 100 != 11 && value % 10 == 1) {
      return appLocalizations.remainingSingular; // остался
    }
    // "осталось" для всех остальных случаев
    return appLocalizations.remainingPlural; // осталось
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allProfiles = ref.watch(profilesProvider);
    final currentProfile = ref.watch(currentProfileProvider);
    final theme = Theme.of(context);

    if (allProfiles.isEmpty) {
      return CommonCard(
        onPressed: () {
          showExtend(
            context,
            builder: (_, type) {
              return AdaptiveSheetScaffold(
                type: type,
                body: AddProfileView(
                  context: context,
                ),
                title: "${appLocalizations.add}${appLocalizations.profile}",
              );
            },
          );
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.add_circle_outline,
                  size: 48,
                ),
                const SizedBox(height: 8),
                Text(appLocalizations.addProfile),
              ],
            ),
          ),
        ),
      );
    }

    final subscriptionInfo = currentProfile?.subscriptionInfo;

    if (currentProfile == null || subscriptionInfo == null) {
      return const SizedBox.shrink();
    }

    final bool isUnlimitedTraffic = subscriptionInfo.total == 0;
    final bool isPerpetual = subscriptionInfo.expire == 0;
    final supportUrl = currentProfile.supportUrl;

    String timeLeftValue = '';
    String timeLeftUnit = '';
    String remainingText = '';
    bool showTimeLeft = false;
    
    if (!isPerpetual) {
      final expireDateTime =
          DateTime.fromMillisecondsSinceEpoch(subscriptionInfo.expire * 1000);
      final difference = expireDateTime.difference(DateTime.now());
      final days = difference.inDays;
      
      // Показываем если осталось 3 дня или меньше
      if (days >= 0 && days <= 3) {
        showTimeLeft = true;
        if (days > 0) {
          // Показываем дни
          timeLeftValue = days.toString();
          timeLeftUnit = _getDaysDeclension(days);
          remainingText = _getRemainingDeclension(days);
        } else {
          // Если 0 дней - показываем часы
          final hours = difference.inHours;
          if (hours >= 0) {
            timeLeftValue = hours.toString();
            timeLeftUnit = _getHoursDeclension(hours);
            remainingText = _getRemainingDeclension(hours);
          } else {
            showTimeLeft = false;
          }
        }
      }
    }

    return CommonCard(
      onPressed: null,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            currentProfile.label ?? appLocalizations.profile,
                            style: theme.textTheme.headlineSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (supportUrl != null && supportUrl.isNotEmpty)
                          IconButton(
                            icon: Icon(
                              supportUrl.toLowerCase().contains('t.me')
                                  ? Icons.telegram
                                  : Icons.launch,
                            ),
                            iconSize: 34,
                            color: theme.colorScheme.primary,
                            onPressed: () {
                              globalState.openUrl(supportUrl);
                            },
                          ),
                        IconButton(
                          icon: const Icon(Icons.sync),
                          iconSize: 34,
                          color: theme.colorScheme.primary,
                          onPressed: () {
                            globalState.appController
                                .updateProfile(currentProfile);
                          },
                        ),
                      ],
                    ),
                    const Spacer(),
                    if (!isUnlimitedTraffic)
                      Builder(builder: (context) {
                        final totalTraffic =
                            TrafficValue(value: subscriptionInfo.total);
                        final usedTrafficValue =
                            subscriptionInfo.upload + subscriptionInfo.download;
                        final usedTraffic =
                            TrafficValue(value: usedTrafficValue);

                        double progress = 0.0;
                        if (subscriptionInfo.total > 0) {
                          progress = usedTrafficValue / subscriptionInfo.total;
                        }
                        progress = progress.clamp(0.0, 1.0);

                        Color progressColor = Colors.green;
                        if (progress > 0.9) {
                          progressColor = Colors.red;
                        } else if (progress > 0.7) {
                          progressColor = Colors.orange;
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${appLocalizations.traffic} ${usedTraffic.showValue} ${usedTraffic.showUnit} / ${totalTraffic.showValue} ${totalTraffic.showUnit}',
                              style: theme.textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 6),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: progress,
                                minHeight: 6,
                                backgroundColor:
                                    theme.colorScheme.surfaceContainerHighest,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    progressColor),
                              ),
                            ),
                          ],
                        );
                      })
                    else
                      Text(
                        appLocalizations.trafficUnlimited,
                        style: theme.textTheme.bodyMedium,
                      ),
                    const SizedBox(height: 12),
                    Text(
                      isPerpetual
                          ? appLocalizations.subscriptionEternal
                          : '${appLocalizations.expiresOn} ${DateFormat('dd.MM.yyyy').format(DateTime.fromMillisecondsSinceEpoch(subscriptionInfo.expire * 1000))}',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              if (showTimeLeft) ...[
                const VerticalDivider(width: 32),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      remainingText,
                      style: theme.textTheme.bodySmall,
                    ),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        timeLeftValue,
                        style: theme.textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    Text(
                      timeLeftUnit,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

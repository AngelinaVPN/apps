import 'package:angelinavpn/common/common.dart';
import 'package:angelinavpn/models/models.dart';
import 'package:angelinavpn/providers/providers.dart';
import 'package:angelinavpn/state.dart';
import 'package:angelinavpn/views/profiles/add_profile.dart';
import 'package:angelinavpn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class MetainfoWidget extends ConsumerWidget {
  const MetainfoWidget({super.key});

  String _getDaysDeclension(int days) {
    if (days % 100 >= 11 && days % 100 <= 19) {
      return appLocalizations.days;
    }
    switch (days % 10) {
      case 1:
        return appLocalizations.day;
      case 2:
      case 3:
      case 4:
        return appLocalizations.daysGenitive;
      default:
        return appLocalizations.days;
    }
  }

  String _getHoursDeclension(int hours) {
    if (hours % 100 >= 11 && hours % 100 <= 19) {
      return appLocalizations.hoursGenitive;
    }
    switch (hours % 10) {
      case 1:
        return appLocalizations.hour;
      case 2:
      case 3:
      case 4:
        return appLocalizations.hoursPlural;
      default:
        return appLocalizations.hoursGenitive;
    }
  }

  String _getRemainingDeclension(int value) {
    if (value % 100 != 11 && value % 10 == 1) {
      return appLocalizations.remainingSingular;
    }
    return appLocalizations.remainingPlural;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allProfiles = ref.watch(profilesProvider);
    final currentProfile = ref.watch(currentProfileProvider);
    final theme = Theme.of(context);

    if (allProfiles.isEmpty) {
      return CommonCard(
        onPressed: () async {
          final url = await globalState.showCommonDialog<String>(
            child: const URLFormDialog(),
          );
          if (url != null) {
            globalState.appController.addProfileFormURL(url);
          }
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

    final isUnlimitedTraffic = subscriptionInfo.total == 0;
    final isPerpetual = subscriptionInfo.expire == 0;
    final supportUrl = currentProfile.providerHeaders['support-url'];

    var timeLeftValue = '';
    var timeLeftUnit = '';
    var remainingText = '';
    var showTimeLeft = false;

    if (!isPerpetual) {
      final expireDateTime =
          DateTime.fromMillisecondsSinceEpoch(subscriptionInfo.expire * 1000);
      final difference = expireDateTime.difference(DateTime.now());
      final days = difference.inDays;

      if (days >= 0 && days <= 3) {
        showTimeLeft = true;
        if (days > 0) {
          timeLeftValue = days.toString();
          timeLeftUnit = _getDaysDeclension(days);
          remainingText = _getRemainingDeclension(days);
        } else {
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

    const cGreen = Color(0xFF00E675);
    const monoSmall = TextStyle(
      fontFamily: 'JetBrainsMono',
      fontSize: 10,
      color: Colors.white38,
      letterSpacing: 0.5,
    );

    return CommonCard(
      onPressed: null,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Terminal section tag + actions row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          '// ',
                          style: TextStyle(
                            fontFamily: 'JetBrainsMono',
                            fontSize: 10,
                            color: cGreen,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            (currentProfile.label ?? appLocalizations.profile).toUpperCase(),
                            style: const TextStyle(
                              fontFamily: 'JetBrainsMono',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 1.5,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (supportUrl != null && supportUrl.isNotEmpty)
                          SizedBox(
                            width: 32,
                            height: 32,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                supportUrl.toLowerCase().contains('t.me')
                                    ? Icons.telegram
                                    : Icons.launch,
                                size: 16,
                              ),
                              color: cGreen,
                              onPressed: () => globalState.openUrl(supportUrl),
                            ),
                          ),
                        SizedBox(
                          width: 32,
                          height: 32,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.sync, size: 16),
                            color: cGreen,
                            onPressed: () =>
                                globalState.appController.updateProfile(currentProfile),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Traffic info
                    if (!isUnlimitedTraffic)
                      Builder(builder: (context) {
                        final totalTraffic =
                            TrafficValue(value: subscriptionInfo.total);
                        final usedTrafficValue =
                            subscriptionInfo.upload + subscriptionInfo.download;
                        final usedTraffic =
                            TrafficValue(value: usedTrafficValue);

                        var progress = 0.0;
                        if (subscriptionInfo.total > 0) {
                          progress = usedTrafficValue / subscriptionInfo.total;
                        }
                        progress = progress.clamp(0.0, 1.0);

                        Color progressColor = cGreen;
                        if (progress > 0.9) {
                          progressColor = Colors.red.shade400;
                        } else if (progress > 0.7) {
                          progressColor = Colors.orange.shade400;
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'traffic: ${usedTraffic.showValue} ${usedTraffic.showUnit} / ${totalTraffic.showValue} ${totalTraffic.showUnit}',
                              style: monoSmall,
                            ),
                            const SizedBox(height: 5),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: LinearProgressIndicator(
                                value: progress,
                                minHeight: 3,
                                backgroundColor: const Color(0xFF1A1A1A),
                                valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                              ),
                            ),
                          ],
                        );
                      })
                    else
                      Text(
                        'traffic: unlimited',
                        style: monoSmall.copyWith(
                          color: cGreen.withValues(alpha: 0.5),
                        ),
                      ),
                    const SizedBox(height: 6),
                    Text(
                      isPerpetual
                          ? 'expires: unlimited'
                          : 'expires: ${DateFormat('dd.MM.yyyy').format(DateTime.fromMillisecondsSinceEpoch(subscriptionInfo.expire * 1000))}',
                      style: monoSmall,
                    ),
                  ],
                ),
              ),
              if (showTimeLeft) ...[
                Container(
                  width: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  color: const Color(0xFF1A1A1A),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      remainingText,
                      style: monoSmall,
                    ),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        timeLeftValue,
                        style: const TextStyle(
                          fontFamily: 'JetBrainsMono',
                          fontWeight: FontWeight.bold,
                          fontSize: 36,
                          color: cGreen,
                        ),
                      ),
                    ),
                    Text(
                      timeLeftUnit,
                      style: monoSmall,
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

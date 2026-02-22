import 'package:angelinavpn/common/common.dart';
import 'package:angelinavpn/enum/enum.dart';
import 'package:angelinavpn/models/models.dart';
import 'package:angelinavpn/state.dart';
import 'package:angelinavpn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NetworkDetection extends ConsumerStatefulWidget {
  const NetworkDetection({super.key});

  @override
  ConsumerState<NetworkDetection> createState() => _NetworkDetectionState();
}

class _NetworkDetectionState extends ConsumerState<NetworkDetection> {
  String _countryCodeToEmoji(String countryCode) {
    final code = countryCode.toUpperCase();
    if (code.length != 2) {
      return countryCode;
    }
    final firstLetter = code.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final secondLetter = code.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }

  @override
  Widget build(BuildContext context) => SizedBox(
      height: getWidgetHeight(1),
      child: ValueListenableBuilder<NetworkDetectionState>(
        valueListenable: detectionState.state,
        builder: (_, state, __) {
          final ipInfo = state.ipInfo;
          final isLoading = state.isLoading;
          return CommonCard(
            onPressed: () {
              final success = detectionState.forceCheck();
              if (!success) {
                globalState.showMessage(
                  title: appLocalizations.tip,
                  message: TextSpan(
                    text: appLocalizations.tooFrequentOperation,
                  ),
                );
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Terminal header: // NET DETECTION
                Container(
                  height: globalState.measure.titleMediumHeight + 16,
                  padding: baseInfoEdgeInsets.copyWith(bottom: 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text(
                        '// ',
                        style: TextStyle(
                          fontFamily: 'JetBrainsMono',
                          fontSize: 10,
                          color: Color(0xFF00E675),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Text(
                          appLocalizations.networkDetection.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'JetBrainsMono',
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.white38,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 28,
                        height: 28,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            globalState.showMessage(
                              title: appLocalizations.tip,
                              message: TextSpan(
                                text: appLocalizations.detectionTip,
                              ),
                              cancelable: false,
                            );
                          },
                          icon: const Icon(
                            Icons.info_outline,
                            size: 14,
                            color: Colors.white24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // IP value + country flag
                Expanded(
                  child: Container(
                    padding: baseInfoEdgeInsets.copyWith(top: 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FadeThroughBox(
                        child: ipInfo != null
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    _countryCodeToEmoji(ipInfo.countryCode),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: FontFamily.twEmoji.value,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Flexible(
                                    child: Text(
                                      ipInfo.ip,
                                      style: const TextStyle(
                                        fontFamily: 'JetBrainsMono',
                                        fontSize: 12,
                                        color: Color(0xFF00E675),
                                        letterSpacing: 0.5,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              )
                            : FadeThroughBox(
                                child: isLoading == false && ipInfo == null
                                    ? const Text(
                                        'timeout',
                                        style: TextStyle(
                                          fontFamily: 'JetBrainsMono',
                                          fontSize: 12,
                                          color: Colors.red,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    : Container(
                                        padding: const EdgeInsets.all(2),
                                        child: const AspectRatio(
                                          aspectRatio: 1,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      ),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
}

import 'package:angelinavpn/common/common.dart';
import 'package:angelinavpn/providers/app.dart';
import 'package:angelinavpn/state.dart';
import 'package:angelinavpn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntranetIP extends StatelessWidget {
  const IntranetIP({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
      height: getWidgetHeight(1),
      child: CommonCard(
        info: Info(
          label: appLocalizations.intranetIP,
          iconData: Icons.devices,
        ),
        onPressed: () {},
        child: Container(
          padding: baseInfoEdgeInsets.copyWith(
            top: 0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: globalState.measure.bodyMediumHeight + 2,
                child: Consumer(
                  builder: (_, ref, __) {
                    final localIp = ref.watch(localIpProvider);
                    return FadeThroughBox(
                      child: localIp != null
                          ? TooltipText(
                              text: Text(
                                localIp.isNotEmpty
                                    ? localIp
                                    : appLocalizations.noNetwork,
                                style: TextStyle(
                                  fontFamily: 'JetBrainsMono',
                                  fontSize: 12,
                                  color: localIp.isNotEmpty
                                      ? const Color(0xFF00E675)
                                      : Colors.white38,
                                  letterSpacing: 0.5,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
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
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
}

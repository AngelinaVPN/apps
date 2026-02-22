import 'package:angelinavpn/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets/angelina_header.dart';
import 'widgets/connect_button.dart';
import 'widgets/matrix_rain.dart';
import 'widgets/servers_section.dart';
import 'widgets/subscription_section.dart';
import 'widgets/terminal_log.dart';
import 'widgets/ticker_view.dart';

class AngelinaView extends ConsumerWidget {
  const AngelinaView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isStart = ref.watch(runTimeProvider.select((s) => s != null));

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Stack(
        children: [
          // ── Matrix rain background (always runs, opacity differs by state) ──
          Positioned.fill(
            child: AnimatedOpacity(
              opacity: isStart ? 0.07 : 0.03,
              duration: const Duration(milliseconds: 1200),
              child: const MatrixRain(active: true),
            ),
          ),

          // ── Main UI ──
          Column(
            children: [
              // Header
              const AngelinaHeader(),

              // Divider
              Container(height: 1, color: const Color(0xFF1A1A1A)),

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Connect button + Terminal log ──
                      SizedBox(
                        height: 240,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: const [
                            SizedBox(
                              width: 188,
                              child: ConnectButton(),
                            ),
                            SizedBox(width: 14),
                            Expanded(
                              child: TerminalLog(),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // ── Subscription section ──
                      const SubscriptionSection(),

                      const SizedBox(height: 16),

                      // ── Servers section ──
                      const ServersSection(),

                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),

              // Bottom divider
              Container(height: 1, color: const Color(0xFF1A1A1A)),

              // ── Ticker ──
              const TickerView(),
            ],
          ),
        ],
      ),
    );
  }
}

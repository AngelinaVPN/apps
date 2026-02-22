import 'package:angelinavpn/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _cGreen = Color(0xFF00E675);

class AngelinaHeader extends ConsumerStatefulWidget {
  const AngelinaHeader({super.key});

  @override
  ConsumerState<AngelinaHeader> createState() => _AngelinaHeaderState();
}

class _AngelinaHeaderState extends ConsumerState<AngelinaHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseCtrl;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  void _syncPulse(bool connected) {
    if (connected && !_pulseCtrl.isAnimating) {
      _pulseCtrl.repeat();
    } else if (!connected && _pulseCtrl.isAnimating) {
      _pulseCtrl.stop();
      _pulseCtrl.value = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isStart = ref.watch(runTimeProvider.select((s) => s != null));
    _syncPulse(isStart);

    final String statusText = isStart ? 'CONNECTED' : 'DISCONNECTED';
    final Color statusColor =
        isStart ? _cGreen : Colors.white.withValues(alpha: 0.4);

    return Container(
      color: const Color(0xFF0A0A0A),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          // --- Logo icon with pulse ring ---
          SizedBox(
            width: 44,
            height: 44,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Pulse ring
                AnimatedBuilder(
                  animation: _pulseCtrl,
                  builder: (_, __) {
                    final scale = 1.0 + _pulseCtrl.value * 0.65;
                    final opacity = isStart ? (1 - _pulseCtrl.value) * 0.25 : 0.0;
                    return Transform.scale(
                      scale: scale,
                      child: Opacity(
                        opacity: opacity.clamp(0, 1),
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _cGreen.withValues(alpha: 0.5),
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                // Background box
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: isStart
                        ? _cGreen.withValues(alpha: 0.15)
                        : Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                // Icon
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: Icon(
                    isStart ? Icons.lock : Icons.lock_outline,
                    key: ValueKey(isStart),
                    color: isStart ? _cGreen : Colors.white.withValues(alpha: 0.4),
                    size: 18,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // --- Title + status ---
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'AngelinaVPN',
                style: TextStyle(
                  fontFamily: 'JetBrainsMono',
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: statusColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    statusText,
                    style: TextStyle(
                      fontFamily: 'JetBrainsMono',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                      letterSpacing: 1.8,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const Spacer(),

          // --- Settings button ---
          GestureDetector(
            onTap: () => _openSettings(context),
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                Icons.tune,
                size: 14,
                color: Colors.white.withValues(alpha: 0.4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0D0D0D),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        side: BorderSide(color: Color(0xFF1E1E1E)),
      ),
      builder: (_) => const _SettingsSheet(),
    );
  }
}

class _SettingsSheet extends ConsumerWidget {
  const _SettingsSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const _SettingsContent();
  }
}

class _SettingsContent extends ConsumerStatefulWidget {
  const _SettingsContent();

  @override
  ConsumerState<_SettingsContent> createState() => _SettingsContentState();
}

class _SettingsContentState extends ConsumerState<_SettingsContent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Text(
                '// ',
                style: TextStyle(
                  fontFamily: 'JetBrainsMono',
                  fontSize: 11,
                  color: _cGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                'SETTINGS',
                style: TextStyle(
                  fontFamily: 'JetBrainsMono',
                  fontSize: 12,
                  color: _cGreen,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.close,
                  size: 16,
                  color: Colors.white.withValues(alpha: 0.3),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFF1A1A1A), height: 1),
          const SizedBox(height: 16),
          Text(
            'Режим: обычное окно в Dock.',
            style: TextStyle(
              fontFamily: 'JetBrainsMono',
              fontSize: 11,
              color: Colors.white.withValues(alpha: 0.45),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'For advanced settings, edit your subscription URL\nin the // ПОДПИСКА section below.',
            style: TextStyle(
              fontFamily: 'JetBrainsMono',
              fontSize: 11,
              color: Colors.white.withValues(alpha: 0.4),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

import 'package:angelinavpn/common/common.dart';
import 'package:angelinavpn/enum/enum.dart';
import 'package:angelinavpn/providers/providers.dart';
import 'package:angelinavpn/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _cGreen = Color(0xFF00E675);
const _cGreenDim = Color(0x1A00E675);
const _cInk = Color(0xFF111111);

class StartButton extends ConsumerStatefulWidget {
  const StartButton({super.key});

  @override
  ConsumerState<StartButton> createState() => _StartButtonState();
}

class _StartButtonState extends ConsumerState<StartButton>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _pressController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _scaleAnimation;
  bool isStart = false;

  @override
  void initState() {
    super.initState();
    isStart = globalState.appState.runTime != null;

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeOut),
    );

    ref.listenManual(
      runTimeProvider.select((state) => state != null),
      (prev, next) {
        if (next != isStart) {
          isStart = next;
          _updatePulse();
        }
      },
      fireImmediately: true,
    );
  }

  void _updatePulse() {
    if (isStart) {
      _pulseController.repeat(reverse: true);
    } else {
      _pulseController.stop();
      _pulseController.value = 0;
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _pressController.dispose();
    super.dispose();
  }

  void handleSwitchStart() {
    isStart = !isStart;
    _updatePulse();
    debouncer.call(
      FunctionTag.updateStatus,
      () {
        globalState.appController.updateStatus(isStart);
      },
      duration: commonDuration,
    );
  }

  void _onTapDown(TapDownDetails _) => _pressController.forward();
  void _onTapUp(TapUpDetails _) => _pressController.reverse();
  void _onTapCancel() => _pressController.reverse();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(startButtonSelectorStateProvider);
    if (!state.isInit || !state.hasProfile) return const SizedBox.shrink();

    final runTime = ref.watch(runTimeProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: AnimatedBuilder(
        animation: Listenable.merge([_pulseController, _pressController]),
        builder: (_, __) => Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: _onTapCancel,
            onTap: handleSwitchStart,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              width: double.infinity,
              height: 64,
              decoration: BoxDecoration(
                color: isStart ? _cGreenDim : _cInk,
                border: Border.all(
                  color: isStart
                      ? _cGreen.withValues(alpha: _pulseAnimation.value * 0.9)
                      : const Color(0xFF1E1E1E),
                  width: isStart ? 1.5 : 1.0,
                ),
                borderRadius: BorderRadius.circular(6),
                boxShadow: isStart
                    ? [
                        BoxShadow(
                          color: _cGreen.withValues(
                              alpha: _pulseAnimation.value * 0.25),
                          blurRadius: 24,
                          spreadRadius: 0,
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      isStart ? Icons.stop : Icons.play_arrow,
                      key: ValueKey(isStart),
                      color: isStart ? _cGreen : Colors.white54,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Label
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Text(
                          isStart ? 'DISCONNECT' : 'CONNECT',
                          key: ValueKey(isStart),
                          style: TextStyle(
                            fontFamily: 'JetBrainsMono',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isStart ? _cGreen : Colors.white70,
                            letterSpacing: 2.5,
                          ),
                        ),
                      ),
                      if (isStart && runTime != null)
                        Text(
                          utils.getTimeText(runTime),
                          style: const TextStyle(
                            fontFamily: 'JetBrainsMono',
                            fontSize: 10,
                            color: Color(0x9900E675),
                            letterSpacing: 1.5,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

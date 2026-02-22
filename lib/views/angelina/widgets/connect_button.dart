import 'dart:async';
import 'dart:math';

import 'package:angelinavpn/providers/providers.dart';
import 'package:angelinavpn/state.dart';
import 'package:angelinavpn/enum/enum.dart';
import 'package:angelinavpn/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _cGreen = Color(0xFF00E675);
const _cInk = Color(0xFF111111);
const _cLine2 = Color(0x1FFFFFFF); // white 12%
const _cDim = Color(0x2DFFFFFF);   // white 18%

class ConnectButton extends ConsumerStatefulWidget {
  const ConnectButton({super.key});

  @override
  ConsumerState<ConnectButton> createState() => _ConnectButtonState();
}

class _ConnectButtonState extends ConsumerState<ConnectButton>
    with TickerProviderStateMixin {
  late AnimationController _glowCtrl;
  late AnimationController _ringCtrl;
  late AnimationController _pressCtrl;

  late Animation<double> _glowAnim;
  late Animation<double> _ringAnim;
  late Animation<double> _pressAnim;

  Timer? _cipherTimer;
  String _cipherText = 'A9F2·3C8E·1B7D';
  final _rng = Random();

  bool _isStart = false;
  bool _isConnecting = false; // We simulate a brief connecting state on toggle
  bool _pressed = false;

  @override
  void initState() {
    super.initState();

    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );
    _glowAnim = Tween<double>(begin: 0.3, end: 0.9).animate(
      CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut),
    );

    _ringCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    _ringAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _ringCtrl, curve: Curves.linear),
    );

    _pressCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _pressAnim = Tween<double>(begin: 1.0, end: 0.93).animate(
      CurvedAnimation(parent: _pressCtrl, curve: Curves.easeOut),
    );

    _isStart = globalState.appState.runTime != null;
    _updateAnimations();

    // Listen for external connection state changes (e.g. from tray/other source)
    ref.listenManual(
      runTimeProvider.select((s) => s != null),
      (_, next) {
        if (next != _isStart) {
          setState(() {
            _isStart = next;
            _updateAnimations();
          });
        }
      },
      fireImmediately: false,
    );
  }

  void _updateAnimations() {
    if (_isStart) {
      _glowCtrl.repeat(reverse: true);
      _ringCtrl.stop();
      _startCipherTimer();
    } else {
      _glowCtrl.stop();
      _glowCtrl.value = 0;
      _cipherTimer?.cancel();
    }
    if (_isConnecting) {
      _ringCtrl.repeat();
    } else {
      _ringCtrl.stop();
      _ringCtrl.value = 0;
    }
  }

  void _startCipherTimer() {
    _cipherTimer?.cancel();
    _cipherTimer = Timer.periodic(const Duration(milliseconds: 450), (_) {
      if (!mounted) return;
      setState(() {
        String hex(int n) {
          const chars = '0123456789ABCDEF';
          return List.generate(n, (_) => chars[_rng.nextInt(chars.length)])
              .join();
        }
        _cipherText = '${hex(4)}·${hex(4)}·${hex(4)}';
      });
    });
  }

  @override
  void dispose() {
    _glowCtrl.dispose();
    _ringCtrl.dispose();
    _pressCtrl.dispose();
    _cipherTimer?.cancel();
    super.dispose();
  }

  void _handleTap() {
    _isStart = !_isStart;
    _updateAnimations();
    debouncer.call(
      FunctionTag.updateStatus,
      () => globalState.appController.updateStatus(_isStart),
      duration: commonDuration,
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasProfile = ref.watch(
      profilesProvider.select((s) => s.isNotEmpty),
    );
    final isInit = ref.watch(initProvider);
    final canConnect = hasProfile && isInit;

    return GestureDetector(
      onTapDown: (_) {
        setState(() => _pressed = true);
        _pressCtrl.forward();
      },
      onTapUp: (_) {
        setState(() => _pressed = false);
        _pressCtrl.reverse();
        if (canConnect || _isStart) _handleTap();
      },
      onTapCancel: () {
        setState(() => _pressed = false);
        _pressCtrl.reverse();
      },
      child: AnimatedBuilder(
        animation: Listenable.merge([_pressCtrl, _glowCtrl, _ringCtrl]),
        builder: (_, __) => Transform.scale(
          scale: _pressAnim.value,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
              color: _isStart
                  ? _cGreen.withValues(alpha: 0.07)
                  : _isConnecting
                      ? _cGreen.withValues(alpha: 0.04)
                      : _cInk,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _isStart
                    ? _cGreen.withValues(alpha: 0.35)
                    : _isConnecting
                        ? _cGreen.withValues(alpha: 0.2)
                        : _cLine2,
                width: 1,
              ),
            ),
            child: Opacity(
              opacity: (!canConnect && !_isStart) ? 0.3 : 1.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),

                  // ---- Big circle ----
                  SizedBox(
                    width: 88,
                    height: 88,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Glow ring (connected)
                        if (_isStart)
                          Opacity(
                            opacity: _glowAnim.value,
                            child: Container(
                              width: 88,
                              height: 88,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: _cGreen.withValues(alpha: 0.15),
                                    blurRadius: 16,
                                    spreadRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                          ),

                        // Spinning arc (connecting)
                        Transform.rotate(
                          angle: _ringAnim.value * 2 * pi,
                          child: AnimatedOpacity(
                            opacity: _isConnecting ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 300),
                            child: SizedBox(
                              width: 76,
                              height: 76,
                              child: CustomPaint(
                                painter: _ArcPainter(),
                              ),
                            ),
                          ),
                        ),

                        // Main circle
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          width: 68,
                          height: 68,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _isStart
                                ? _cGreen.withValues(alpha: 0.15)
                                : _isConnecting
                                    ? _cGreen.withValues(alpha: 0.06)
                                    : Colors.white.withValues(alpha: 0.04),
                            border: Border.all(
                              color: _isStart
                                  ? _cGreen.withValues(alpha: 0.5)
                                  : _cLine2,
                              width: _isStart ? 1.5 : 1,
                            ),
                          ),
                        ),

                        // Icon
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: _isConnecting
                              ? _SpinnerDot(key: const ValueKey('spin'))
                              : Icon(
                                  _isStart ? Icons.stop : Icons.play_arrow,
                                  key: ValueKey(_isStart),
                                  color: _isStart
                                      ? Colors.white.withValues(alpha: 0.85)
                                      : (canConnect ? _cGreen : _cDim),
                                  size: 26,
                                ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ---- Label ----
                  SizedBox(
                    height: 14,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        _LabelText(
                          text: 'CONNECTING',
                          color: _cGreen.withValues(alpha: 0.7),
                          visible: _isConnecting,
                        ),
                        _LabelText(
                          text: 'DISCONNECT',
                          color: Colors.white.withValues(alpha: 0.35),
                          visible: _isStart && !_isConnecting,
                        ),
                        _LabelText(
                          text: 'CONNECT',
                          color: canConnect
                              ? _cGreen.withValues(alpha: 0.7)
                              : _cDim,
                          visible: !_isStart && !_isConnecting,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // ---- Cipher / sub-label ----
                  SizedBox(
                    height: 14,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        _LabelText(
                          text: _cipherText,
                          color: _cGreen.withValues(alpha: 0.4),
                          visible: _isStart,
                          fontSize: 9,
                        ),
                        _LabelText(
                          text: '· · ·',
                          color: _cGreen.withValues(alpha: 0.3),
                          visible: _isConnecting,
                        ),
                        _LabelText(
                          text: 'PROTECTED',
                          color: _cDim,
                          visible: !_isStart && !_isConnecting,
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LabelText extends StatelessWidget {
  final String text;
  final Color color;
  final bool visible;
  final double fontSize;

  const _LabelText({
    required this.text,
    required this.color,
    required this.visible,
    this.fontSize = 10,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'JetBrainsMono',
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: 2,
        ),
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        colors: [
          const Color(0xFF00E675),
          const Color(0x0000E675),
        ],
      ).createShader(rect);

    canvas.drawArc(
      rect.deflate(1),
      -pi / 2,
      pi * 1.3, // ~0.65 of full circle
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_ArcPainter old) => false;
}

class _SpinnerDot extends StatefulWidget {
  const _SpinnerDot({super.key});

  @override
  State<_SpinnerDot> createState() => _SpinnerDotState();
}

class _SpinnerDotState extends State<_SpinnerDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => Transform.rotate(
        angle: _ctrl.value * 2 * pi,
        child: CustomPaint(
          size: const Size(20, 20),
          painter: _SpinnerPainter(),
        ),
      ),
    );
  }
}

class _SpinnerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFF00E675);
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      -pi / 2,
      pi * 1.4,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_SpinnerPainter old) => false;
}

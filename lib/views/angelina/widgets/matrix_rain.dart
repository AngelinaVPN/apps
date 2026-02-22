import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class MatrixRain extends StatefulWidget {
  final bool active;
  const MatrixRain({super.key, required this.active});

  @override
  State<MatrixRain> createState() => _MatrixRainState();
}

class _MatrixRainState extends State<MatrixRain>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  late List<double> _drops;
  final _rng = Random();
  Duration _last = Duration.zero;

  static const _numCols = 36; // ~500 / 14

  @override
  void initState() {
    super.initState();
    _drops = List.generate(_numCols, (_) => _rng.nextDouble() * 50);
    _ticker = createTicker(_onTick)..start();
  }

  void _onTick(Duration elapsed) {
    if (!widget.active) return;
    if ((elapsed - _last).inMilliseconds < 80) return;
    _last = elapsed;
    if (!mounted) return;
    setState(() {
      for (var i = 0; i < _drops.length; i++) {
        _drops[i] += 1;
        if (_drops[i] * 16 > 820 && _rng.nextDouble() > 0.97) {
          _drops[i] = 0;
        }
      }
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.active ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1200),
      child: RepaintBoundary(
        child: CustomPaint(
          painter: _MatrixPainter(List<double>.from(_drops), _rng),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class _MatrixPainter extends CustomPainter {
  final List<double> drops;
  final Random rng;

  static const _chars =
      'アイウエオカキクケコ01ABCDEF·XRAY·VLESS·TLS';

  _MatrixPainter(this.drops, this.rng);

  @override
  void paint(Canvas canvas, Size size) {
    const colW = 14.0;
    const rowH = 16.0;

    for (var i = 0; i < drops.length; i++) {
      final x = i * colW;
      if (x > size.width) break;

      final y = size.height - drops[i] * rowH;
      final charIdx = rng.nextInt(_chars.length);
      final char = _chars[charIdx];

      // Bright head
      _draw(canvas, char, x, y, const Color(0x9900E675));

      // Dim trail
      if (drops[i] > 1) {
        final trailIdx = rng.nextInt(_chars.length);
        _draw(canvas, _chars[trailIdx], x, y + rowH, const Color(0x2600E675));
      }
    }
  }

  void _draw(Canvas canvas, String char, double x, double y, Color color) {
    final tp = TextPainter(
      text: TextSpan(
        text: char,
        style: TextStyle(
          fontSize: 11,
          color: color,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(x, y));
  }

  @override
  bool shouldRepaint(_MatrixPainter old) => true;
}

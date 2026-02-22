import 'package:flutter/material.dart';

class TickerView extends StatefulWidget {
  const TickerView({super.key});

  @override
  State<TickerView> createState() => _TickerViewState();
}

class _TickerViewState extends State<TickerView>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  static const _items = [
    'XRAY', '·', 'TLS 1.3', '·', 'REALITY', '·', 'AES-256-GCM', '·',
    'VLESS', '·', 'gRPC', '·', 'SHA-256', '·', 'ECDH', '·',
    'XRAY', '·', 'TLS 1.3', '·', 'REALITY', '·', 'AES-256-GCM', '·',
    'VLESS', '·', 'gRPC', '·', 'SHA-256', '·', 'ECDH', '·',
  ];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat();
    _anim = Tween<double>(begin: 0, end: -720).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      color: const Color(0xFF111111),
      child: ClipRect(
        child: AnimatedBuilder(
          animation: _anim,
          builder: (_, __) => Transform.translate(
            offset: Offset(_anim.value, 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final item in _items)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      item,
                      style: TextStyle(
                        fontFamily: 'JetBrainsMono',
                        fontSize: 11,
                        fontWeight:
                            item == '·' ? FontWeight.normal : FontWeight.w600,
                        color: item == '·'
                            ? Colors.white.withValues(alpha: 0.18)
                            : const Color(0xFF00E675).withValues(alpha: 0.5),
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

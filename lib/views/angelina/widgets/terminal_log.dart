import 'dart:async';

import 'package:angelinavpn/models/models.dart';
import 'package:angelinavpn/providers/providers.dart';
import 'package:angelinavpn/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _cGreen = Color(0xFF00E675);

class TerminalLog extends ConsumerStatefulWidget {
  const TerminalLog({super.key});

  @override
  ConsumerState<TerminalLog> createState() => _TerminalLogState();
}

class _TerminalLogState extends ConsumerState<TerminalLog> {
  bool _showCursor = true;
  Timer? _cursorTimer;
  int _epoch = 0;
  bool _isStart = false;

  final _lines = [
    _TermLine.empty(),
    _TermLine.empty(),
    _TermLine.empty(),
    _TermLine.empty(),
  ];

  @override
  void initState() {
    super.initState();
    _isStart = globalState.appState.runTime != null;
    _updateLines();
    _cursorTimer = Timer.periodic(const Duration(milliseconds: 550), (_) {
      if (mounted) setState(() => _showCursor = !_showCursor);
    });
    // Listen for connection state changes via riverpod
    ref.listenManual(
      runTimeProvider.select((s) => s != null),
      (_, next) {
        if (next != _isStart) {
          _isStart = next;
          _updateLines();
        }
      },
      fireImmediately: false,
    );
  }

  @override
  void dispose() {
    _cursorTimer?.cancel();
    super.dispose();
  }

  void _updateLines() {
    _epoch++;
    final epoch = _epoch;
    final List<_TermLine> next;

    if (_isStart) {
      next = [
        _TermLine('\$', 'vpn connect --server active', Colors.white.withValues(alpha: 0.5)),
        _TermLine('✓', 'status: CONNECTED', _cGreen),
        _TermLine('✓', 'protocol: VLESS+REALITY', _cGreen.withValues(alpha: 0.8)),
        _TermLine('✓', 'private_nets: DIRECT', _cGreen.withValues(alpha: 0.6)),
      ];
    } else {
      next = [
        _TermLine('\$', 'vpn connect --server ...', Colors.white.withValues(alpha: 0.5)),
        _TermLine('○', 'status: DISCONNECTED', Colors.white.withValues(alpha: 0.4)),
        _TermLine.empty(),
        _TermLine.empty(),
      ];
    }

    for (var i = 0; i < 4; i++) {
      final delay = i * 120;
      final line = next[i];
      Future.delayed(Duration(milliseconds: delay), () {
        if (!mounted || _epoch != epoch) return;
        setState(() => _lines[i] = line);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(currentProfileProvider);
    final subInfo = profile?.subscriptionInfo;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0D0D0D),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // ── Mac window chrome ──
          _buildChrome(),

          Container(height: 1, color: Colors.white.withValues(alpha: 0.07)),

          // ── Subscription info ──
          _buildSubInfo(subInfo),

          Container(height: 1, color: Colors.white.withValues(alpha: 0.07)),

          // ── Status lines ──
          Expanded(child: _buildStatusLines()),
        ],
      ),
    );
  }

  Widget _buildChrome() => Container(
        color: const Color(0xFF080808),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
        child: Row(
          children: [
            _dot(const Color(0xFFFF5F57)),
            const SizedBox(width: 4),
            _dot(const Color(0xFFFFBD2E)),
            const SizedBox(width: 4),
            _dot(const Color(0xFF28CA41)),
            const Spacer(),
            Text(
              'angelinavpn — session',
              style: TextStyle(
                fontFamily: 'JetBrainsMono',
                fontSize: 12,
                color: Colors.white.withValues(alpha: 0.18),
              ),
            ),
            const Spacer(),
          ],
        ),
      );

  Widget _dot(Color color) => Container(
        width: 9,
        height: 9,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );

  Widget _buildSubInfo(SubscriptionInfo? info) => Container(
        color: const Color(0xFF060A06),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Traffic
            Row(
              children: [
                _hashLabel(),
                _dimLabel('traffic:  '),
                Text(
                  _trafficStr(info),
                  style: TextStyle(
                    fontFamily: 'JetBrainsMono',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withValues(alpha: 0.75),
                  ),
                ),
                const Spacer(),
                if (_trafficPct(info) > 0)
                  _progressBar(_trafficPct(info)),
              ],
            ),
            const SizedBox(height: 5),
            // Days
            Row(
              children: [
                _hashLabel(),
                _dimLabel('subscription: '),
                Text(
                  _daysStr(info),
                  style: TextStyle(
                    fontFamily: 'JetBrainsMono',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _daysColor(info),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _hashLabel() => Text(
        '# ',
        style: TextStyle(
          fontFamily: 'JetBrainsMono',
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: _cGreen.withValues(alpha: 0.5),
        ),
      );

  Widget _dimLabel(String text) => Text(
        text,
        style: TextStyle(
          fontFamily: 'JetBrainsMono',
          fontSize: 13,
          color: Colors.white.withValues(alpha: 0.18),
        ),
      );

  Widget _progressBar(double pct) => SizedBox(
        width: 80,
        height: 6,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: Stack(
            children: [
              Container(color: Colors.white.withValues(alpha: 0.12)),
              FractionallySizedBox(
                widthFactor: pct.clamp(0.0, 1.0),
                child: Container(
                  color: pct > 0.85
                      ? Colors.red.withValues(alpha: 0.7)
                      : _cGreen.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildStatusLines() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final line in _lines)
              AnimatedOpacity(
                opacity: line.visible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 100),
                child: SizedBox(
                  height: 22,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 15,
                        child: Text(
                          line.prefix,
                          style: const TextStyle(
                            fontFamily: 'JetBrainsMono',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: _cGreen,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          line.text,
                          style: TextStyle(
                            fontFamily: 'JetBrainsMono',
                            fontSize: 13,
                            color: line.color,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            // Cursor row
            SizedBox(
              height: 22,
              child: Row(
                children: [
                  const SizedBox(
                    width: 15,
                    child: Text(
                      '\$',
                      style: TextStyle(
                        fontFamily: 'JetBrainsMono',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _cGreen,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedOpacity(
                    opacity: _showCursor ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 80),
                    child: Container(
                      width: 7,
                      height: 14,
                      color: _cGreen,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  // ── Helpers ──

  String _trafficStr(SubscriptionInfo? info) {
    if (info == null) return '—';
    final used = info.upload + info.download;
    final total = info.total;
    if (total <= 0 && used <= 0) return '—';
    const gb = 1024 * 1024 * 1024;
    final usedGB = used / gb;
    if (total <= 0) return '${usedGB.toStringAsFixed(2)} GB used';
    final totalGB = total / gb;
    return '${usedGB.toStringAsFixed(2)} / ${totalGB.toStringAsFixed(2)} GB';
  }

  String _daysStr(SubscriptionInfo? info) {
    if (info == null || info.expire <= 0) return '—';
    final exp = DateTime.fromMillisecondsSinceEpoch(info.expire * 1000);
    final diff = exp.difference(DateTime.now()).inDays;
    if (diff <= 0) return 'EXPIRED';
    return '$diff days left';
  }

  Color _daysColor(SubscriptionInfo? info) {
    if (info == null || info.expire <= 0) {
      return Colors.white.withValues(alpha: 0.4);
    }
    final exp = DateTime.fromMillisecondsSinceEpoch(info.expire * 1000);
    final diff = exp.difference(DateTime.now()).inDays;
    if (diff > 7) return _cGreen.withValues(alpha: 0.85);
    if (diff > 0) return const Color(0xFFFFCC33);
    return Colors.red.withValues(alpha: 0.8);
  }

  double _trafficPct(SubscriptionInfo? info) {
    if (info == null || info.total <= 0) return 0;
    return (info.upload + info.download) / info.total;
  }
}

class _TermLine {
  final String prefix;
  final String text;
  final Color color;
  final bool visible;

  const _TermLine(this.prefix, this.text, this.color) : visible = true;

  const _TermLine.empty()
      : prefix = '\$',
        text = '',
        color = Colors.transparent,
        visible = false;
}

import 'package:angelinavpn/models/models.dart';
import 'package:angelinavpn/providers/providers.dart';
import 'package:angelinavpn/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _cGreen = Color(0xFF00E675);
const _cInk = Color(0xFF111111);
const _cLine = Color(0xFF1A1A1A);

class ServersSection extends ConsumerWidget {
  const ServersSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(currentGroupsStateProvider).value;
    final selectedMap = ref.watch(selectedMapProvider);

    if (groups.isEmpty) return const SizedBox.shrink();

    final groupByName = {for (final group in groups) group.name: group};
    final List<_ServerItem> items = [];
    final seen = <String>{};

    for (final group in groups) {
      final selectedName = selectedMap[group.name] ?? group.now ?? '';
      final proxies = _collectLeafProxies(group, groupByName);
      for (final proxy in proxies) {
        final key = '${group.name}:${proxy.name}';
        if (!seen.add(key)) continue;
        items.add(
          _ServerItem(
            proxy: proxy,
            groupName: group.name,
            isSelected: selectedName == proxy.name,
          ),
        );
      }
    }

    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Section tag ──
        _SectionTag(text: 'СЕРВЕРЫ'),
        const SizedBox(height: 8),

        // ── Grid ──
        Container(
          decoration: BoxDecoration(
            color: _cInk,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: _cLine),
          ),
          clipBehavior: Clip.antiAlias,
          child: _buildGrid(items, items.length <= 5 ? 1 : 2),
        ),
      ],
    );
  }

  Widget _buildGrid(List<_ServerItem> items, int columnCount) {
    final safeColumnCount = columnCount < 1 ? 1 : columnCount;
    final rows = <Widget>[];
    for (var i = 0; i < items.length; i += safeColumnCount) {
      final rowItems = items.skip(i).take(safeColumnCount).toList();
      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(safeColumnCount * 2 - 1, (index) {
              if (index.isOdd) {
                return Container(width: 1, color: _cLine);
              }
              final itemIndex = index ~/ 2;
              if (itemIndex < rowItems.length) {
                return Expanded(child: _ServerRow(item: rowItems[itemIndex]));
              }
              return const Expanded(child: SizedBox());
            }),
          ),
        ),
      );
      // Divider between rows
      if (i + safeColumnCount < items.length) {
        rows.add(Container(height: 1, color: _cLine));
      }
    }
    return Column(
      children: rows,
      mainAxisSize: MainAxisSize.min,
    );
  }

  List<Proxy> _collectLeafProxies(
    Group group,
    Map<String, Group> groupByName, {
    Set<String>? visited,
  }) {
    final currentVisited = visited ?? <String>{};
    if (!currentVisited.add(group.name)) return const [];

    final result = <Proxy>[];
    for (final proxy in group.all) {
      final nestedGroup = groupByName[proxy.name];
      if (nestedGroup != null) {
        result.addAll(
          _collectLeafProxies(
            nestedGroup,
            groupByName,
            visited: currentVisited,
          ),
        );
      } else {
        result.add(proxy);
      }
    }
    return result;
  }
}

class _ServerRow extends StatelessWidget {
  final _ServerItem item;
  const _ServerRow({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final proxy = item.proxy;
    final isSelected = item.isSelected;

    return GestureDetector(
      onTap: () {
        globalState.appController
            .changeProxyDebounce(item.groupName, proxy.name);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        color: isSelected
            ? _cGreen.withValues(alpha: 0.07)
            : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
        child: Row(
          children: [
            // Selection dot
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: isSelected
                    ? _cGreen
                    : Colors.white.withValues(alpha: 0.18),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),

            // Name + address
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _MarqueeText(
                    text: proxy.name,
                    style: TextStyle(
                      fontFamily: 'JetBrainsMono',
                      fontSize: 13,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isSelected
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.4),
                    ),
                  ),
                  if (proxy.serverDescription != null &&
                      proxy.serverDescription!.isNotEmpty)
                    Text(
                      proxy.serverDescription!,
                      style: TextStyle(
                        fontFamily: 'JetBrainsMono',
                        fontSize: 11,
                        color: Colors.white.withValues(alpha: 0.18),
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                ],
              ),
            ),

            const SizedBox(width: 6),

            // Type badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected
                    ? _cGreen.withValues(alpha: 0.15)
                    : Colors.white.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text(
                proxy.type.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'JetBrainsMono',
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? _cGreen
                      : Colors.white.withValues(alpha: 0.18),
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MarqueeText extends StatefulWidget {
  const _MarqueeText({
    required this.text,
    required this.style,
  });

  final String text;
  final TextStyle style;

  @override
  State<_MarqueeText> createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<_MarqueeText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  double _textWidth = 0;
  double _maxWidth = 0;
  bool _shouldScroll = false;
  static const double _gap = 28;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _MarqueeText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text || oldWidget.style != widget.style) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() {});
      });
    }
  }

  void _updateAnimation() {
    if (!_shouldScroll) {
      _controller.stop();
      _controller.value = 0;
      return;
    }
    final overflow = (_textWidth - _maxWidth) + _gap;
    final durationMs = (overflow * 45).clamp(2800, 9000).round();
    _controller.duration = Duration(milliseconds: durationMs);
    if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _maxWidth = constraints.maxWidth;
        final painter = TextPainter(
          text: TextSpan(text: widget.text, style: widget.style),
          maxLines: 1,
          textDirection: TextDirection.ltr,
        )..layout(minWidth: 0, maxWidth: double.infinity);
        _textWidth = painter.width;
        _shouldScroll = _textWidth > _maxWidth + 2;
        _updateAnimation();

        if (!_shouldScroll) {
          return Text(
            widget.text,
            style: widget.style,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          );
        }

        final lineHeight =
            (widget.style.fontSize ?? 13) * (widget.style.height ?? 1.2);

        return ClipRect(
          child: SizedBox(
            height: lineHeight,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (_, __) {
                final totalShift = _textWidth + _gap;
                final dx = -totalShift * _controller.value;
                return Transform.translate(
                  offset: Offset(dx, 0),
                  child: Row(
                    children: [
                      Text(widget.text, style: widget.style, maxLines: 1),
                      const SizedBox(width: _gap),
                      Text(widget.text, style: widget.style, maxLines: 1),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _ServerItem {
  final Proxy proxy;
  final String groupName;
  final bool isSelected;

  const _ServerItem({
    required this.proxy,
    required this.groupName,
    required this.isSelected,
  });
}

class _SectionTag extends StatelessWidget {
  final String text;
  const _SectionTag({required this.text});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '// ',
            style: TextStyle(
              fontFamily: 'JetBrainsMono',
              fontSize: 12,
              color: _cGreen.withValues(alpha: 0.4),
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'JetBrainsMono',
              fontSize: 12,
              color: _cGreen,
              fontWeight: FontWeight.w600,
              letterSpacing: 2.5,
            ),
          ),
        ],
      );
}

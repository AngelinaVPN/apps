import 'package:angelinavpn/common/common.dart';
import 'package:angelinavpn/enum/enum.dart';
import 'package:angelinavpn/widgets/fade_box.dart';
import 'package:flutter/material.dart';

import 'text.dart';

class Info {

  const Info({
    required this.label,
    this.iconData,
  });
  final String label;
  final IconData? iconData;
}

class InfoHeader extends StatelessWidget {

  const InfoHeader({
    super.key,
    required this.info,
    this.padding,
    List<Widget>? actions,
  }) : actions = actions ?? const [];
  final Info info;
  final List<Widget> actions;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) => Padding(
      padding: padding ?? baseInfoEdgeInsets,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
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
                    info.label.toUpperCase(),
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
              ],
            ),
          ),
          if (actions.isNotEmpty) ...[
            const SizedBox(width: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ...actions,
              ],
            ),
          ],
        ],
      ),
    );
}

class CommonCard extends StatelessWidget {
  const CommonCard({
    super.key,
    bool? isSelected,
    this.type = CommonCardType.plain,
    this.onPressed,
    this.selectWidget,
    this.radius = 6,
    required this.child,
    this.padding,
    this.enterAnimated = false,
    this.info,
  }) : isSelected = isSelected ?? false;

  final bool enterAnimated;
  final bool isSelected;
  final void Function()? onPressed;
  final Widget? selectWidget;
  final Widget child;
  final EdgeInsets? padding;
  final Info? info;
  final CommonCardType type;
  final double radius;

  // final WidgetStateProperty<Color?>? backgroundColor;
  // final WidgetStateProperty<BorderSide?>? borderSide;

  BorderSide getBorderSide(BuildContext context, Set<WidgetState> states) {
    final colorScheme = context.colorScheme;
    if (type == CommonCardType.filled) {
      return BorderSide.none;
    }
    final hoverColor = isSelected
        ? colorScheme.primary.opacity80
        : colorScheme.primary.opacity60;
    if (states.contains(WidgetState.hovered) ||
        states.contains(WidgetState.focused) ||
        states.contains(WidgetState.pressed)) {
      return BorderSide(
        color: hoverColor,
      );
    }
    return BorderSide(
      color: isSelected
          ? colorScheme.primary
          : colorScheme.surfaceContainerHighest,
    );
  }

  Color? getBackgroundColor(BuildContext context, Set<WidgetState> states) {
    final colorScheme = context.colorScheme;
    if (type == CommonCardType.filled) {
      if (isSelected) {
        return const Color(0x1A00E675);
      }
      return colorScheme.surfaceContainer.withValues(alpha: 0.85);
    }
    if (isSelected) {
      return const Color(0x1200E675);
    }
    return colorScheme.surfaceContainerLow.withValues(alpha: 0.85);
  }

  @override
  Widget build(BuildContext context) {
    var childWidget = child;

    if (info != null) {
      childWidget = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InfoHeader(
            padding: baseInfoEdgeInsets.copyWith(
              bottom: 0,
            ),
            info: info!,
          ),
          Flexible(
            flex: 1,
            child: child,
          ),
        ],
      );
    }

    if (selectWidget != null && isSelected) {
      final children = <Widget>[];
      children.add(childWidget);
      children.add(
        Positioned.fill(
          child: selectWidget!,
        ),
      );
      childWidget = Stack(
        children: children,
      );
    }

    final card = OutlinedButton(
      onLongPress: null,
      clipBehavior: Clip.antiAlias,
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        shape: WidgetStatePropertyAll(
          RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        iconColor: WidgetStatePropertyAll(context.colorScheme.primary),
        iconSize: WidgetStateProperty.all(20),
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) => getBackgroundColor(context, states),
        ),
        side: WidgetStateProperty.resolveWith(
          (states) => getBorderSide(context, states),
        ),
      ),
      onPressed: onPressed,
      child: childWidget,
    );

    return switch (enterAnimated) {
      true => FadeScaleEnterBox(
          child: card,
        ),
      false => card,
    };
  }
}

class SelectIcon extends StatelessWidget {
  const SelectIcon({super.key});

  @override
  Widget build(BuildContext context) => Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(
        color: Color(0xFF00E675),
        shape: BoxShape.circle,
      ),
    );
}

class SettingsBlock extends StatelessWidget {

  const SettingsBlock({
    super.key,
    required this.title,
    required this.settings,
  });
  final String title;
  final List<Widget> settings;

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          InfoHeader(
            info: Info(
              label: title,
            ),
          ),
          Card(
            color: context.colorScheme.surfaceContainer.withValues(alpha: 0.85),
            child: Column(
              children: settings,
            ),
          ),
        ],
      ),
    );
}

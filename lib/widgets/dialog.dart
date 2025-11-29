import 'dart:math';

import 'package:flclashx/providers/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommonDialog extends ConsumerWidget {

  const CommonDialog({
    super.key,
    required this.title,
    this.actions,
    this.child,
    this.padding,
    this.overrideScroll = false,
    this.backgroundColor,
  });
  final String title;
  final Widget? child;
  final List<Widget>? actions;
  final EdgeInsets? padding;
  final bool overrideScroll;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = ref.watch(viewSizeProvider);
    return AlertDialog(
      title: Text(title),
      actions: actions,
      contentPadding: padding,
      backgroundColor: backgroundColor,
      content: Container(
        constraints: BoxConstraints(
          maxHeight: min(
            size.height - 40,
            500,
          ),
          maxWidth: 300,
        ),
        width: size.width - 40,
        child: !overrideScroll
            ? SingleChildScrollView(
                child: child,
              )
            : child,
      ),
    );
  }
}

class CommonModal extends ConsumerWidget {

  const CommonModal({
    super.key,
    this.child,
  });
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = ref.watch(viewSizeProvider);
    return Center(
      child: Container(
        width: size.width * 0.85,
        height: size.height * 0.85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: child,
      ),
    );
  }
}

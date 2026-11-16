import 'package:flutter/material.dart';
import 'package:vignesh_project_01/core/themes/app_dimens.dart';

/// A [Column] with the standard screen padding ([AppSpacing.screen]).
/// Use as the root of a screen's body instead of hand-rolled
/// `Padding(child: Column(...))`.
class AppBodyColumn extends StatelessWidget {
  const AppBodyColumn({
    super.key,
    required this.children,
    this.padding = AppSpacing.screen,
    this.spacing = 0,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
  });

  final List<Widget> children;
  final EdgeInsetsGeometry padding;
  final double spacing;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        spacing: spacing,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        children: children,
      ),
    );
  }
}

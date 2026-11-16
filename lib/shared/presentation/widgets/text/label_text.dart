import 'package:flutter/material.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/text/app_text.dart';

enum _LabelTextSize { large, medium, small }

/// `label*` roles of the app [TextTheme].
class LabelText extends AppText {
  const LabelText.large(
    super.text, {
    super.key,
    super.style,
    super.color,
    super.overflow,
    super.maxLines,
    super.textAlign,
    super.softWrap,
  }) : _size = _LabelTextSize.large;

  const LabelText.medium(
    super.text, {
    super.key,
    super.style,
    super.color,
    super.overflow,
    super.maxLines,
    super.textAlign,
    super.softWrap,
  }) : _size = _LabelTextSize.medium;

  const LabelText.small(
    super.text, {
    super.key,
    super.style,
    super.color,
    super.overflow,
    super.maxLines,
    super.textAlign,
    super.softWrap,
  }) : _size = _LabelTextSize.small;

  final _LabelTextSize _size;

  static TextStyle? largeStyle(BuildContext context) =>
      Theme.of(context).textTheme.labelLarge;
  static TextStyle? mediumStyle(BuildContext context) =>
      Theme.of(context).textTheme.labelMedium;
  static TextStyle? smallStyle(BuildContext context) =>
      Theme.of(context).textTheme.labelSmall;

  @override
  TextStyle? themeStyle(BuildContext context) => switch (_size) {
    _LabelTextSize.large => largeStyle(context),
    _LabelTextSize.medium => mediumStyle(context),
    _LabelTextSize.small => smallStyle(context),
  };
}

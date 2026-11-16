import 'package:flutter/material.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/text/app_text.dart';

enum _BodyTextSize { large, medium, small }

/// `body*` roles of the app [TextTheme].
class BodyText extends AppText {
  const BodyText.large(
    super.text, {
    super.key,
    super.style,
    super.color,
    super.overflow,
    super.maxLines,
    super.textAlign,
    super.softWrap,
  }) : _size = _BodyTextSize.large;

  const BodyText.medium(
    super.text, {
    super.key,
    super.style,
    super.color,
    super.overflow,
    super.maxLines,
    super.textAlign,
    super.softWrap,
  }) : _size = _BodyTextSize.medium;

  const BodyText.small(
    super.text, {
    super.key,
    super.style,
    super.color,
    super.overflow,
    super.maxLines,
    super.textAlign,
    super.softWrap,
  }) : _size = _BodyTextSize.small;

  final _BodyTextSize _size;

  static TextStyle? largeStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge;
  static TextStyle? mediumStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium;
  static TextStyle? smallStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall;

  @override
  TextStyle? themeStyle(BuildContext context) => switch (_size) {
    _BodyTextSize.large => largeStyle(context),
    _BodyTextSize.medium => mediumStyle(context),
    _BodyTextSize.small => smallStyle(context),
  };
}

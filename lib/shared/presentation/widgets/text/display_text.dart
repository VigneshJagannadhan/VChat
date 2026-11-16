import 'package:flutter/material.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/text/app_text.dart';

enum _DisplayTextSize { large, medium, small }

/// `display*` roles of the app [TextTheme].
class DisplayText extends AppText {
  const DisplayText.large(
    super.text, {
    super.key,
    super.style,
    super.color,
    super.overflow,
    super.maxLines,
    super.textAlign,
    super.softWrap,
  }) : _size = _DisplayTextSize.large;

  const DisplayText.medium(
    super.text, {
    super.key,
    super.style,
    super.color,
    super.overflow,
    super.maxLines,
    super.textAlign,
    super.softWrap,
  }) : _size = _DisplayTextSize.medium;

  const DisplayText.small(
    super.text, {
    super.key,
    super.style,
    super.color,
    super.overflow,
    super.maxLines,
    super.textAlign,
    super.softWrap,
  }) : _size = _DisplayTextSize.small;

  final _DisplayTextSize _size;

  static TextStyle? largeStyle(BuildContext context) =>
      Theme.of(context).textTheme.displayLarge;
  static TextStyle? mediumStyle(BuildContext context) =>
      Theme.of(context).textTheme.displayMedium;
  static TextStyle? smallStyle(BuildContext context) =>
      Theme.of(context).textTheme.displaySmall;

  @override
  TextStyle? themeStyle(BuildContext context) => switch (_size) {
    _DisplayTextSize.large => largeStyle(context),
    _DisplayTextSize.medium => mediumStyle(context),
    _DisplayTextSize.small => smallStyle(context),
  };
}

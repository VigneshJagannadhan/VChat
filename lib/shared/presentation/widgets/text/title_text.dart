import 'package:flutter/material.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/text/app_text.dart';

enum _TitleTextSize { large, medium, small }

/// `title*` roles of the app [TextTheme].
class TitleText extends AppText {
  const TitleText.large(
    super.text, {
    super.key,
    super.style,
    super.color,
    super.overflow,
    super.maxLines,
    super.textAlign,
    super.softWrap,
  }) : _size = _TitleTextSize.large;

  const TitleText.medium(
    super.text, {
    super.key,
    super.style,
    super.color,
    super.overflow,
    super.maxLines,
    super.textAlign,
    super.softWrap,
  }) : _size = _TitleTextSize.medium;

  const TitleText.small(
    super.text, {
    super.key,
    super.style,
    super.color,
    super.overflow,
    super.maxLines,
    super.textAlign,
    super.softWrap,
  }) : _size = _TitleTextSize.small;

  final _TitleTextSize _size;

  static TextStyle? largeStyle(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge;
  static TextStyle? mediumStyle(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium;
  static TextStyle? smallStyle(BuildContext context) =>
      Theme.of(context).textTheme.titleSmall;

  @override
  TextStyle? themeStyle(BuildContext context) => switch (_size) {
    _TitleTextSize.large => largeStyle(context),
    _TitleTextSize.medium => mediumStyle(context),
    _TitleTextSize.small => smallStyle(context),
  };
}

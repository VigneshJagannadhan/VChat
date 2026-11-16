import 'package:flutter/material.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/text/app_text.dart';

enum _HeadlineTextSize { large, medium, small }

/// `headline*` roles of the app [TextTheme].
class HeadlineText extends AppText {
  const HeadlineText.large(
    super.text, {
    super.key,
    super.style,
    super.color,
    super.overflow,
    super.maxLines,
    super.textAlign,
    super.softWrap,
  }) : _size = _HeadlineTextSize.large;

  const HeadlineText.medium(
    super.text, {
    super.key,
    super.style,
    super.color,
    super.overflow,
    super.maxLines,
    super.textAlign,
    super.softWrap,
  }) : _size = _HeadlineTextSize.medium;

  const HeadlineText.small(
    super.text, {
    super.key,
    super.style,
    super.color,
    super.overflow,
    super.maxLines,
    super.textAlign,
    super.softWrap,
  }) : _size = _HeadlineTextSize.small;

  final _HeadlineTextSize _size;

  static TextStyle? largeStyle(BuildContext context) =>
      Theme.of(context).textTheme.headlineLarge;
  static TextStyle? mediumStyle(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium;
  static TextStyle? smallStyle(BuildContext context) =>
      Theme.of(context).textTheme.headlineSmall;

  @override
  TextStyle? themeStyle(BuildContext context) => switch (_size) {
    _HeadlineTextSize.large => largeStyle(context),
    _HeadlineTextSize.medium => mediumStyle(context),
    _HeadlineTextSize.small => smallStyle(context),
  };
}

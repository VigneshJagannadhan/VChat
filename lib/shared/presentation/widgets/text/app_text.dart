import 'package:flutter/material.dart';

/// Base for the semantic text widgets ([DisplayText], [HeadlineText],
/// [TitleText], [BodyText], [LabelText]).
///
/// Pick the widget that matches the text's role, not its look. Each one also
/// exposes static style getters (e.g. `BodyText.mediumStyle(context)`) for
/// places that need a raw [TextStyle], such as a `copyWith`.
abstract class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    super.key,
    this.style,
    this.color,
    this.overflow,
    this.maxLines,
    this.textAlign,
    this.softWrap,
  });

  final String text;

  /// Merged on top of the role's theme style.
  final TextStyle? style;
  final Color? color;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextAlign? textAlign;
  final bool? softWrap;

  @protected
  TextStyle? themeStyle(BuildContext context);

  @override
  Widget build(BuildContext context) {
    var resolved = themeStyle(context)?.merge(style) ?? style;
    if (color != null) {
      resolved = (resolved ?? const TextStyle()).copyWith(color: color);
    }
    return Text(
      text,
      style: resolved,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
      softWrap: softWrap,
    );
  }
}

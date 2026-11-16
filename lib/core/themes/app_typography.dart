import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Builds the app [TextTheme] (Poppins).
///
/// Styles carry size + weight + a default color from the [ColorScheme].
/// In UI code pick the role that matches the text's purpose, e.g.
/// `context.textTheme.bodyLarge`, and only `copyWith(color: ...)` when the
/// text sits on a non-default background.
abstract final class AppTypography {
  static TextTheme textTheme(ColorScheme colors) {
    TextStyle style(double size, FontWeight weight, Color color) =>
        GoogleFonts.poppins(
          fontSize: size.sp,
          fontWeight: weight,
          color: color,
        );

    final primary = colors.onSurface;
    final secondary = colors.onSurfaceVariant;

    return TextTheme(
      displayLarge: style(48, FontWeight.w700, primary),
      displayMedium: style(40, FontWeight.w700, primary),
      displaySmall: style(36, FontWeight.w700, primary),
      headlineLarge: style(32, FontWeight.w700, primary),
      headlineMedium: style(28, FontWeight.w600, primary),
      headlineSmall: style(24, FontWeight.w700, primary),
      titleLarge: style(20, FontWeight.w600, primary),
      titleMedium: style(16, FontWeight.w500, primary),
      titleSmall: style(14, FontWeight.w500, primary),
      bodyLarge: style(16, FontWeight.w400, primary),
      bodyMedium: style(14, FontWeight.w400, primary),
      bodySmall: style(12, FontWeight.w400, secondary),
      labelLarge: style(16, FontWeight.w500, primary),
      labelMedium: style(12, FontWeight.w500, secondary),
      labelSmall: style(10, FontWeight.w400, secondary),
    );
  }
}

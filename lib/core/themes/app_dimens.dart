import 'package:flutter/widgets.dart';

/// Layout tokens. Use these instead of literal numbers in UI code so spacing
/// stays on one scale across screens.
///
/// These are plain `const` values (not a ThemeExtension) because they don't
/// change between themes, and `const` lets them be used inside
/// `const EdgeInsets` / `const SizedBox`.
abstract final class AppSpacing {
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;

  /// Default horizontal padding for a screen's content.
  static const double screenHorizontal = xl;

  /// Default vertical padding for a screen's content.
  static const double screenVertical = xl;

  static const EdgeInsets screen = EdgeInsets.symmetric(
    horizontal: screenHorizontal,
    vertical: screenVertical,
  );
}

abstract final class AppRadius {
  static const double sm = 4;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 30;
}

abstract final class AppSizes {
  /// Height of buttons and single-line inputs.
  static const double controlHeight = 52;

  static const double iconXs = 12;
  static const double iconSm = 16;
  static const double iconMd = 24;
  static const double iconLg = 48;
  static const double iconXl = 64;

  static const double avatarSm = 20;
  static const double avatarLg = 50;

  static const double loader = 50;
  static const double sendButton = 48;
}

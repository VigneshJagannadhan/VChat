import 'package:flutter/material.dart';

/// Raw color palette.
///
/// Only the theme layer (`lib/core/themes/`) should read these directly.
/// UI code must go through `context.colors` (ColorScheme) or
/// `context.chatColors` (ChatColors) so a palette change stays in one place.
abstract final class AppColors {
  // ---------------------------------------------------------------------------
  // Neutrals (near-black, layered so surfaces have depth)
  // ---------------------------------------------------------------------------
  static const Color black = Color(0xFF0E0E12); // base / scaffold
  static const Color surfaceLowest = Color(0xFF09090C);
  static const Color surfaceLow = Color(0xFF121218);
  static const Color surface = Color(0xFF16161D); // bars, cards
  static const Color surfaceHigh = Color(0xFF1F1F28); // inputs, received bubble
  static const Color surfaceHighest = Color(0xFF2A2A35); // chips, dialogs, menus

  static const Color outline = Color(0xFF6B6680); // 3.5:1 on black, input borders
  static const Color outlineVariant = Color(0xFF2A2A35); // dividers

  static const Color textPrimary = Color(0xFFF4F2FA);
  static const Color textSecondary = Color(0xFFA09CB0);
  static const Color white = Color(0xFFFFFFFF);

  // ---------------------------------------------------------------------------
  // Brand
  // ---------------------------------------------------------------------------
  /// Fills with white text on top (5.7:1 vs white).
  static const Color violet = Color(0xFF7C3AED);

  /// Violet text / icons on dark backgrounds (7.1:1 vs black).
  static const Color violetLight = Color(0xFFA78BFA);

  static const Color violetDeep = Color(0xFF2E1065);
  static const Color violetPale = Color(0xFFDDD6FE);

  /// Pink-violet accent, also safe under white text (4.7:1).
  static const Color pinkViolet = Color(0xFFC026D3);
  static const Color pinkVioletDeep = Color(0xFF4A044E);
  static const Color pinkVioletPale = Color(0xFFF5D0FE);

  // ---------------------------------------------------------------------------
  // Status
  // ---------------------------------------------------------------------------
  static const Color success = Color(0xFF22C55E);

  /// Error text / icons on dark backgrounds.
  static const Color error = Color(0xFFF87171);

  /// Destructive fills with white text on top (4.8:1).
  static const Color errorStrong = Color(0xFFDC2626);

  /// Error icon on top of the violet sent bubble.
  static const Color errorOnViolet = Color(0xFFFECACA);
}

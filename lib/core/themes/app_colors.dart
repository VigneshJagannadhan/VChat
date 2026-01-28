import 'package:flutter/material.dart';

class AppColors {
  /// NAMED COLORS
  static Color get primaryColor => c0101ff;
  static Color get secondaryColor => c161F28;
  static Color get scaffoldBackgroundColor => cWhite;
  static Color get appbarBackgroundColor => primaryColor;

  static const lightBackground = Colors.white;
  static const lightText = Colors.black;

  static const darkBackground = Color(0xFF1A2530);
  static const darkText = Colors.white;

  static const Color onlineIndicator = Color(0xFF4CAF50);
  static const Color typingBubbleBackground = Color(0xFFE0E0E0);

  /// GENERAL COLORS
  static Color get cWhite => Colors.white;
  static Color get cBlack => Colors.black;
  static Color get cGrey => Colors.grey;
  static Color get cGrey300 => Colors.grey.shade300;
  static Color get cGrey600 => Colors.grey.shade600;
  static Color get cGrey800 => Colors.grey.shade800;

  /// CUSTOM COLORS
  static Color get c0101ff => Color.fromARGB(255, 1, 132, 255);
  static Color get c161F28 => Color(0xFF161F28);
}

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

  /// GENERAL COLORS
  static Color get cWhite => Colors.white;
  static Color get cBlack => Colors.black;
  static Color get cGrey => Colors.grey;
  static Color get cGrey600 => Colors.grey.shade600;
  static Color get cGrey800 => Colors.grey.shade800;
  static Color get cGreeen => Colors.green;

  /// CUSTOM COLORS
  static Color get c0101ff => Color(0xFF0101ff);
  static Color get c161F28 => Color(0xFF161F28);
}

import 'package:flutter/material.dart';
import 'package:vignesh_project_01/core/themes/app_colors.dart';
import 'package:vignesh_project_01/core/themes/app_styles.dart';

ThemeData get theme => ThemeData(
  brightness: Brightness.dark,

  // Core Colors
  primaryColor: AppColors.primaryColor,
  scaffoldBackgroundColor: AppColors.darkBackground,

  // Global Color Scheme (IMPORTANT)
  colorScheme: const ColorScheme.dark().copyWith(
    primary: AppColors.primaryColor,
    surface: AppColors.darkBackground,
    onSurface: AppColors.cWhite,
    onPrimary: AppColors.cWhite,
  ),

  // Global Icon Theme
  iconTheme: IconThemeData(color: AppColors.cWhite),

  // AppBar
  appBarTheme: AppBarTheme(
    centerTitle: true,
    backgroundColor: AppColors.darkBackground,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColors.cWhite),
    titleTextStyle: AppStyles.ts16W400cWhite,
  ),

  // Dialog
  dialogTheme: DialogThemeData(
    backgroundColor: AppColors.darkBackground,
    titleTextStyle: TextStyle(
      color: AppColors.cWhite,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    contentTextStyle: TextStyle(color: AppColors.cGrey, fontSize: 14),
  ),

  // Global Text Theme (CRITICAL)
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: AppColors.cWhite),
    bodyMedium: TextStyle(color: AppColors.cWhite),
    bodySmall: TextStyle(color: AppColors.cGrey),

    titleLarge: TextStyle(color: AppColors.cWhite),
    titleMedium: TextStyle(color: AppColors.cWhite),
    titleSmall: TextStyle(color: AppColors.cGrey),

    labelLarge: TextStyle(color: AppColors.cWhite),
    labelMedium: TextStyle(color: AppColors.cGrey),
    labelSmall: TextStyle(color: AppColors.cGrey),
  ),

  // Input Fields (TextFormField, TextField)
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkBackground,
    labelStyle: TextStyle(color: AppColors.cGrey),
    hintStyle: TextStyle(color: AppColors.cGrey),
  ),

  // BottomSheet, Cards, Surfaces
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: AppColors.darkBackground,
  ),

  cardTheme: CardThemeData(color: AppColors.darkBackground),
);

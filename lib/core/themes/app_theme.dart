import 'package:flutter/material.dart';
import 'package:vignesh_project_01/core/themes/app_colors.dart';

ThemeData get theme => ThemeData(
  scaffoldBackgroundColor: AppColors.lightBackground,
  dialogTheme: DialogThemeData(
    backgroundColor: AppColors.scaffoldBackgroundColor,
  ),
  primaryColor: AppColors.primaryColor,
  appBarTheme: AppBarTheme(centerTitle: true, backgroundColor: Colors.white),
);

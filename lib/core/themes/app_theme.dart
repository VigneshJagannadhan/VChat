import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vignesh_project_01/core/themes/app_colors.dart';
import 'package:vignesh_project_01/core/themes/app_typography.dart';
import 'package:vignesh_project_01/core/themes/chat_colors.dart';

abstract final class AppTheme {
  /// Every role is set explicitly so nothing falls back to Material defaults
  /// (e.g. the teal `secondary` of `ColorScheme.dark()`).
  ///
  /// Note: `primary` is a vivid violet meant for fills (buttons, FAB, bubbles).
  /// It is too dark for small text on black, so violet text/links use
  /// `tertiary` instead.
  static const ColorScheme _darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.violet,
    onPrimary: AppColors.white,
    primaryContainer: AppColors.violetDeep,
    onPrimaryContainer: AppColors.violetPale,
    secondary: AppColors.pinkViolet,
    onSecondary: AppColors.white,
    secondaryContainer: AppColors.pinkVioletDeep,
    onSecondaryContainer: AppColors.pinkVioletPale,
    tertiary: AppColors.violetLight,
    onTertiary: AppColors.black,
    tertiaryContainer: AppColors.violetDeep,
    onTertiaryContainer: AppColors.violetPale,
    error: AppColors.error,
    onError: AppColors.black,
    errorContainer: AppColors.errorStrong,
    onErrorContainer: AppColors.white,
    surface: AppColors.black,
    onSurface: AppColors.textPrimary,
    onSurfaceVariant: AppColors.textSecondary,
    surfaceDim: AppColors.black,
    surfaceBright: AppColors.surfaceHighest,
    surfaceContainerLowest: AppColors.surfaceLowest,
    surfaceContainerLow: AppColors.surfaceLow,
    surfaceContainer: AppColors.surface,
    surfaceContainerHigh: AppColors.surfaceHigh,
    surfaceContainerHighest: AppColors.surfaceHighest,
    outline: AppColors.outline,
    outlineVariant: AppColors.outlineVariant,
    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: AppColors.textPrimary,
    onInverseSurface: AppColors.surface,
    inversePrimary: AppColors.violet,
    // No violet tint on elevated surfaces; depth comes from the surface levels.
    surfaceTint: Colors.transparent,
  );

  static ThemeData get dark {
    const colors = _darkScheme;
    final text = AppTypography.textTheme(colors);
    final radius = BorderRadius.circular(20.r);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colors,
      textTheme: text,
      // Still read by PrimaryButton / VkElevatedButton.
      primaryColor: colors.primary,
      scaffoldBackgroundColor: colors.surface,
      canvasColor: colors.surface,
      extensions: const [ChatColors.dark],

      iconTheme: IconThemeData(color: colors.onSurface),

      appBarTheme: AppBarThemeData(
        centerTitle: true,
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: text.titleMedium,
        iconTheme: IconThemeData(color: colors.onSurface),
      ),

      bottomAppBarTheme: BottomAppBarThemeData(
        color: colors.surfaceContainer,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),

      dividerTheme: DividerThemeData(
        color: colors.outlineVariant,
        thickness: 1,
        space: 1,
      ),

      listTileTheme: ListTileThemeData(
        titleTextStyle: text.titleMedium,
        subtitleTextStyle: text.bodyMedium?.copyWith(
          color: colors.onSurfaceVariant,
        ),
        leadingAndTrailingTextStyle: text.labelSmall,
        iconColor: colors.onSurfaceVariant,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          textStyle: text.labelLarge,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: radius),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.tertiary,
          textStyle: text.labelLarge,
        ),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        elevation: 0,
        shape: const CircleBorder(),
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colors.primary,
      ),

      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colors.tertiary,
        selectionColor: colors.primary.withValues(alpha: 0.4),
        selectionHandleColor: colors.tertiary,
      ),

      inputDecorationTheme: InputDecorationThemeData(
        filled: true,
        fillColor: colors.surfaceContainerHigh,
        labelStyle: text.bodyLarge?.copyWith(color: colors.onSurfaceVariant),
        hintStyle: text.bodyLarge?.copyWith(color: colors.onSurfaceVariant),
        floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
          final color = states.contains(WidgetState.error)
              ? colors.error
              : states.contains(WidgetState.focused)
              ? colors.tertiary
              : colors.onSurfaceVariant;
          return text.bodySmall!.copyWith(color: color);
        }),
        errorStyle: text.bodySmall?.copyWith(color: colors.error),
        // Used for the border of filled fields, including the vk_custom_widgets
        // fields that only pass a shape via `border:`.
        activeIndicatorBorder: WidgetStateBorderSide.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return BorderSide(
              color: colors.onSurface.withValues(alpha: 0.12),
            );
          }
          if (states.contains(WidgetState.error)) {
            return BorderSide(
              color: colors.error,
              width: states.contains(WidgetState.focused) ? 2 : 1,
            );
          }
          if (states.contains(WidgetState.focused)) {
            return BorderSide(color: colors.primary, width: 2);
          }
          return BorderSide(color: colors.outline);
        }),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: colors.surfaceContainerHigh,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: text.titleLarge,
        contentTextStyle: text.bodyMedium?.copyWith(
          color: colors.onSurfaceVariant,
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: colors.surfaceContainerHighest,
        contentTextStyle: text.bodyMedium,
        behavior: SnackBarBehavior.floating,
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colors.surfaceContainer,
        surfaceTintColor: Colors.transparent,
      ),

      cardTheme: CardThemeData(
        color: colors.surfaceContainer,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }
}

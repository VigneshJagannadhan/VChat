import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vignesh_project_01/core/themes/app_colors.dart';

class AppStyles {
  /// Core generator for all text styles
  static TextStyle text({
    required double size,
    required FontWeight weight,
    required Color color,
  }) {
    return GoogleFonts.poppins(
      fontSize: size.sp,
      fontWeight: weight,
      color: color,
    );
  }

  // ---------------------------------------------------------------------------
  // SIZE 10
  // ---------------------------------------------------------------------------

  static TextStyle get ts10W400cBlack =>
      text(size: 10, weight: FontWeight.w400, color: AppColors.cBlack);
  static TextStyle get ts10W400cWhite =>
      text(size: 10, weight: FontWeight.w400, color: AppColors.cWhite);
  static TextStyle get ts10W400cPrimary =>
      text(size: 10, weight: FontWeight.w400, color: AppColors.primaryColor);
  static TextStyle get ts10W400cSecondary =>
      text(size: 10, weight: FontWeight.w400, color: AppColors.secondaryColor);

  static TextStyle get ts10W500cBlack =>
      text(size: 10, weight: FontWeight.w500, color: AppColors.cBlack);
  static TextStyle get ts10W600cBlack =>
      text(size: 10, weight: FontWeight.w600, color: AppColors.cBlack);
  static TextStyle get ts10W700cBlack =>
      text(size: 10, weight: FontWeight.w700, color: AppColors.cBlack);

  // ---------------------------------------------------------------------------
  // SIZE 12
  // ---------------------------------------------------------------------------

  static TextStyle get ts12W400cBlack =>
      text(size: 12, weight: FontWeight.w400, color: AppColors.cBlack);
  static TextStyle get ts12W400cWhite =>
      text(size: 12, weight: FontWeight.w400, color: AppColors.cWhite);
  static TextStyle get ts12W400cPrimary =>
      text(size: 12, weight: FontWeight.w400, color: AppColors.primaryColor);
  static TextStyle get ts12W400cSecondary =>
      text(size: 12, weight: FontWeight.w400, color: AppColors.secondaryColor);

  static TextStyle get ts12W500cBlack =>
      text(size: 12, weight: FontWeight.w500, color: AppColors.cBlack);
  static TextStyle get ts12W600cBlack =>
      text(size: 12, weight: FontWeight.w600, color: AppColors.cBlack);
  static TextStyle get ts12W700cBlack =>
      text(size: 12, weight: FontWeight.w700, color: AppColors.cBlack);

  // ---------------------------------------------------------------------------
  // SIZE 14
  // ---------------------------------------------------------------------------

  static TextStyle get ts14W400cBlack =>
      text(size: 14, weight: FontWeight.w400, color: AppColors.cBlack);
  static TextStyle get ts14W400cWhite =>
      text(size: 14, weight: FontWeight.w400, color: AppColors.cWhite);
  static TextStyle get ts14W400cPrimary =>
      text(size: 14, weight: FontWeight.w400, color: AppColors.primaryColor);
  static TextStyle get ts14W400cSecondary =>
      text(size: 14, weight: FontWeight.w400, color: AppColors.secondaryColor);

  static TextStyle get ts14W500cBlack =>
      text(size: 14, weight: FontWeight.w500, color: AppColors.cBlack);
  static TextStyle get ts14W600cBlack =>
      text(size: 14, weight: FontWeight.w600, color: AppColors.cBlack);
  static TextStyle get ts14W700cBlack =>
      text(size: 14, weight: FontWeight.w700, color: AppColors.cBlack);

  // ---------------------------------------------------------------------------
  // SIZE 16
  // ---------------------------------------------------------------------------

  static TextStyle get ts16W400cBlack =>
      text(size: 16, weight: FontWeight.w400, color: AppColors.cBlack);
  static TextStyle get ts16W400cWhite =>
      text(size: 16, weight: FontWeight.w400, color: AppColors.cWhite);
  static TextStyle get ts16W400cPrimary =>
      text(size: 16, weight: FontWeight.w400, color: AppColors.primaryColor);
  static TextStyle get ts16W400cSecondary =>
      text(size: 16, weight: FontWeight.w400, color: AppColors.secondaryColor);

  static TextStyle get ts16W500cBlack =>
      text(size: 16, weight: FontWeight.w500, color: AppColors.cBlack);
  static TextStyle get ts16W600cBlack =>
      text(size: 16, weight: FontWeight.w600, color: AppColors.cBlack);
  static TextStyle get ts16W700cBlack =>
      text(size: 16, weight: FontWeight.w700, color: AppColors.cBlack);

  // ---------------------------------------------------------------------------
  // SIZE 20
  // ---------------------------------------------------------------------------

  static TextStyle get ts20W400cBlack =>
      text(size: 20, weight: FontWeight.w400, color: AppColors.cBlack);
  static TextStyle get ts20W400cWhite =>
      text(size: 20, weight: FontWeight.w400, color: AppColors.cWhite);
  static TextStyle get ts20W400cPrimary =>
      text(size: 20, weight: FontWeight.w400, color: AppColors.primaryColor);
  static TextStyle get ts20W400cSecondary =>
      text(size: 20, weight: FontWeight.w400, color: AppColors.secondaryColor);

  static TextStyle get ts20W600cBlack =>
      text(size: 20, weight: FontWeight.w600, color: AppColors.cBlack);
  static TextStyle get ts20W700cBlack =>
      text(size: 20, weight: FontWeight.w700, color: AppColors.cBlack);

  // ---------------------------------------------------------------------------
  // SIZE 24
  // ---------------------------------------------------------------------------

  static TextStyle get ts24W400cBlack =>
      text(size: 24, weight: FontWeight.w400, color: AppColors.cBlack);
  static TextStyle get ts24W400cWhite =>
      text(size: 24, weight: FontWeight.w400, color: AppColors.cWhite);
  static TextStyle get ts24W600cBlack =>
      text(size: 24, weight: FontWeight.w600, color: AppColors.cBlack);
  static TextStyle get ts24W700cBlack =>
      text(size: 24, weight: FontWeight.w700, color: AppColors.cBlack);

  // ---------------------------------------------------------------------------
  // SIZE 28
  // ---------------------------------------------------------------------------

  static TextStyle get ts28W400cPrimary =>
      text(size: 28, weight: FontWeight.w400, color: AppColors.primaryColor);
  static TextStyle get ts28W600cPrimary =>
      text(size: 28, weight: FontWeight.w600, color: AppColors.primaryColor);
  static TextStyle get ts28W700cPrimary =>
      text(size: 28, weight: FontWeight.w700, color: AppColors.primaryColor);

  // ---------------------------------------------------------------------------
  // SIZE 30
  // ---------------------------------------------------------------------------

  static TextStyle get ts30W400cBlack =>
      text(size: 30, weight: FontWeight.w400, color: AppColors.cBlack);
  static TextStyle get ts30W600cBlack =>
      text(size: 30, weight: FontWeight.w600, color: AppColors.cBlack);
  static TextStyle get ts30W700cBlack =>
      text(size: 30, weight: FontWeight.w700, color: AppColors.cBlack);

  // ---------------------------------------------------------------------------
  // SIZE 32
  // ---------------------------------------------------------------------------

  static TextStyle get ts32W400cWhite =>
      text(size: 32, weight: FontWeight.w400, color: AppColors.cWhite);
  static TextStyle get ts32W600cWhite =>
      text(size: 32, weight: FontWeight.w600, color: AppColors.cWhite);
  static TextStyle get ts32W700cWhite =>
      text(size: 32, weight: FontWeight.w700, color: AppColors.cWhite);

  // ---------------------------------------------------------------------------
  // Dynamic utility (escape hatch)
  // ---------------------------------------------------------------------------

  static TextStyle dynamic(double size, FontWeight weight, Color color) =>
      text(size: size, weight: weight, color: color);
}

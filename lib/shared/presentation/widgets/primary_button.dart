import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vignesh_project_01/core/themes/app_colors.dart';
import 'package:vignesh_project_01/core/themes/app_styles.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
    this.color,
    this.isLoading = false,
  });

  final String label;
  final Function() onTap;
  final Color? color;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.h,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? () {} : onTap,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          backgroundColor: color ?? Theme.of(context).primaryColor,
        ),
        child: isLoading
            ? CupertinoActivityIndicator(color: AppColors.cWhite)
            : Text(label, style: AppStyles.ts16W400cWhite),
      ),
    );
  }
}

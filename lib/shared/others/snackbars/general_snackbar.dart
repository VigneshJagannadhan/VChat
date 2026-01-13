import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vignesh_project_01/core/constants/app_constants.dart';
import 'package:vignesh_project_01/core/themes/app_styles.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showGeneralSnackbar({
  required BuildContext context,
  required String? errorMessage,
  bool isFailure = true,
}) => ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.w),
    content: Row(
      children: [
        SizedBox(
          width: 40.w,
          height: 40.h,
          child: SvgPicture.asset(
            isFailure ? AppConstants.errorSvg : AppConstants.successSvg,
            colorFilter: ColorFilter.mode(
              isFailure ? Colors.red : Colors.green,
              BlendMode.srcIn,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            errorMessage ?? "Something went wrong!",
            style: AppStyles.ts16W400cWhite,
          ),
        ),
      ],
    ),
  ),
);

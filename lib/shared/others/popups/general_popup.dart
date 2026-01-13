import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:vignesh_project_01/core/constants/app_constants.dart';
import 'package:vignesh_project_01/core/themes/app_colors.dart';
import 'package:vignesh_project_01/core/themes/app_styles.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/primary_button.dart';

Future<bool?> showGeneralPopup({
  required BuildContext context,
  required String? title,
  required String? message,
  String? confirmLabel,
  String? cancelLabel,
  bool singleButton = false,
  bool barrierDismissible = true,
}) async {
  return await showDialog<bool?>(
    barrierDismissible: barrierDismissible,
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: .center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h),
            Text(title ?? 'Confirm', style: AppStyles.ts20W400cBlack),
            SizedBox(height: 20.h),
            Lottie.asset(AppConstants.lottieError, height: 100.h),
            SizedBox(height: 20.h),
            Text(
              message ?? 'Are you sure you want to perform this action?',
              style: AppStyles.ts12W400cBlack,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            PrimaryButton(
              onTap: () => Navigator.of(context).pop(true),
              label: confirmLabel ?? 'OK',
              color: AppColors.primaryColor,
            ),
            if (!singleButton) SizedBox(height: 10.h),
            if (!singleButton)
              PrimaryButton(
                onTap: () => Navigator.of(context).pop(false),
                label: cancelLabel ?? 'Cancel',
                color: Colors.red,
              ),
          ],
        ),
      ),
    ),
  );
}

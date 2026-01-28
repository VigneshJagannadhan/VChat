import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:vignesh_project_01/core/constants/app_constants.dart';
import 'package:vignesh_project_01/core/themes/app_styles.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(AppConstants.lottieLoading, width: 100.r, height: 100.r),
        SizedBox(height: 20.h),
        Text(text, style: AppStyles.ts12W400cBlack),
      ],
    );
  }
}

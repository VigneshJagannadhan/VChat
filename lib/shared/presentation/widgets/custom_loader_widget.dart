import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:vignesh_project_01/core/constants/app_constants.dart';
import 'package:vignesh_project_01/core/themes/app_styles.dart';

class CustomLoaderWidget extends StatelessWidget {
  const CustomLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Lottie.asset(AppConstants.lottieLoading, width: 50.r, height: 50.r),
          SizedBox(height: 10.h),
          Text('Loading...', style: AppStyles.ts16W400cPrimary),
        ],
      ),
    );
  }
}

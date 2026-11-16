import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:vignesh_project_01/core/constants/app_constants.dart';
import 'package:vignesh_project_01/core/extensions/theme_extensions.dart';

class CustomLoaderWidget extends StatelessWidget {
  const CustomLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Lottie.asset(AppConstants.lottieLoading, width: 50.r, height: 50.r),
          SizedBox(height: 10.h),
          Text(
            'Loading...',
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colors.tertiary,
            ),
          ),
        ],
      ),
    );
  }
}

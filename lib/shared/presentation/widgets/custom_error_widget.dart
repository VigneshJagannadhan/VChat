import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vignesh_project_01/core/constants/app_constants.dart';
import 'package:vignesh_project_01/core/extensions/theme_extensions.dart';
import 'package:vignesh_project_01/l10n/app_localizations.dart';
import 'package:vk_custom_widgets/vk_custom_widgets.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required this.message, this.onRetry});

  final String message;
  final Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            SvgPicture.asset(
              width: 50.h,
              height: 50.h,
              AppConstants.errorSvg,
              colorFilter: ColorFilter.mode(
                context.colors.error,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(height: 10.h),
            Text(message, style: context.textTheme.bodyMedium),
            SizedBox(height: 20.h),
            VkElevatedButton(
              onPressed: onRetry,
              label: AppLocalizations.of(context)!.retryButtonLabel,
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}

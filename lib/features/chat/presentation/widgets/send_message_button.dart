import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vignesh_project_01/core/constants/app_constants.dart';
import 'package:vignesh_project_01/core/themes/app_colors.dart';

class SendMessageButton extends StatelessWidget {
  const SendMessageButton({super.key, required this.onTap});

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(25.r),
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: AppColors.primaryColor,
        radius: 25.r,
        child: SvgPicture.asset(
          AppConstants.sendSvg,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          width: 24.w,
          height: 24.h,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vignesh_project_01/core/themes/app_colors.dart';
import 'package:vignesh_project_01/core/themes/app_styles.dart';

class ChatViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      title: Text('A', style: AppStyles.ts16W400cBlack),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size(1.sw, kToolbarHeight.h);
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vignesh_project_01/core/themes/app_colors.dart';
import 'package:vignesh_project_01/core/themes/app_styles.dart';

class ChatViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatViewAppBar({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      title: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            child: Icon(Icons.person, color: Colors.white),
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: .start,
            children: [
              Text(name, style: AppStyles.ts16W400cBlack),
              Text('Last seen on 12:00 PM', style: AppStyles.ts10W400cBlack),
            ],
          ),
        ],
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size(1.sw, kToolbarHeight.h);
}

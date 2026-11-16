import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vignesh_project_01/core/themes/app_styles.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.chat_bubble_outline_rounded,
          size: 64.r,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        SizedBox(height: 20.h),
        Text(text, style: AppStyles.ts12W400cBlack),
      ],
    );
  }
}

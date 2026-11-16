import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vignesh_project_01/core/extensions/theme_extensions.dart';

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
          color: context.colors.onSurfaceVariant,
        ),
        SizedBox(height: 20.h),
        Text(
          text,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

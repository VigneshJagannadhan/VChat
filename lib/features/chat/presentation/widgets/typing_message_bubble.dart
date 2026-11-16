import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vignesh_project_01/core/extensions/theme_extensions.dart';

class TypingMessageBubble extends StatelessWidget {
  const TypingMessageBubble({super.key});

  @override
  Widget build(BuildContext context) {
    final chatColors = context.chatColors;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(left: 20.w),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: ShapeDecoration(
          color: chatColors.receivedBubble,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        child: Text(
          'Typing...',
          style: context.textTheme.labelSmall?.copyWith(
            color: chatColors.onReceivedBubbleMuted,
          ),
        ),
      ),
    );
  }
}

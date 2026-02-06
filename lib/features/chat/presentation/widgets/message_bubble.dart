import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vignesh_project_01/core/extensions/date_time_extensions.dart';
import 'package:vignesh_project_01/core/themes/app_styles.dart';
import 'package:vignesh_project_01/core/utils/enums.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/message_entity.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message});

  final MessageEntity message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      alignment: message.isSentByMe
          ? Alignment.centerRight
          : Alignment.centerLeft,

      child: Container(
        constraints: BoxConstraints(maxWidth: 0.7.sw),
        margin: EdgeInsets.only(top: 5.h),
        padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 5.h),
        decoration: BoxDecoration(
          color: message.isSentByMe
              ? Colors.blueAccent.shade400
              : Colors.grey[300],
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisSize: .min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: Text(
                message.content ?? "",
                style: message.isSentByMe
                    ? AppStyles.ts16W400cWhite
                    : AppStyles.ts16W400cBlack,
              ),
            ),
            SizedBox(width: 5.w),
            Text(
              (message.createdAt ?? DateTime.now()).toLocal().timeFormat(),
              style: message.isSentByMe
                  ? AppStyles.ts10W400cWhite
                  : AppStyles.ts10W400cBlack,
            ),
            if (message.isSentByMe) SizedBox(width: 5.w),
            if (message.isSentByMe) _getIconData,
          ],
        ),
      ),
    );
  }

  Icon get _getIconData {
    switch (message.status) {
      case MessageStatus.pending:
        return Icon(Icons.timelapse_outlined, size: 10.sp, color: Colors.grey);
      case MessageStatus.failed:
        return Icon(Icons.error_outline, size: 10.sp, color: Colors.red);
      case MessageStatus.success:
        return Icon(Icons.check_circle, size: 10.sp, color: Colors.green);
      default:
        return Icon(Icons.timelapse_outlined, size: 10.sp);
    }
  }
}

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
      child: Column(
        crossAxisAlignment: message.isSentByMe ? .end : .start,
        children: [
          Container(
            constraints: BoxConstraints(minWidth: 0.3.sw, maxWidth: 0.7.sw),
            padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 10.h),
            decoration: BoxDecoration(
              color: message.isSentByMe
                  ? Colors.blueAccent.shade400
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              message.content ?? "",
              style: message.isSentByMe
                  ? AppStyles.ts16W400cWhite
                  : AppStyles.ts16W400cBlack,
            ),
          ),
          !(message.isSentByMe)
              ? SizedBox(height: 10.h)
              : Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 5.h,
                  ),
                  child: Row(
                    mainAxisSize: .min,
                    children: [
                      Text(
                        (message.createdAt ?? DateTime.now())
                            .toLocal()
                            .messageFormat(),
                        style: AppStyles.ts10W400cBlack,
                      ),
                      SizedBox(width: 5.w),
                      _getIconData,
                    ],
                  ),
                ),
        ],
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vignesh_project_01/core/extensions/date_time_extensions.dart';
import 'package:vignesh_project_01/core/themes/app_styles.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/message_entity.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message});

  final MessageEntity message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: Text(
              (message.createdAt ?? DateTime.now()).toLocal().messageFormat(),
              style: AppStyles.ts10W400cBlack,
            ),
          ),
        ],
      ),
    );
  }
}

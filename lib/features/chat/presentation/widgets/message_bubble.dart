import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vignesh_project_01/core/extensions/date_time_extensions.dart';
import 'package:vignesh_project_01/core/extensions/theme_extensions.dart';
import 'package:vignesh_project_01/core/utils/enums.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/message_entity.dart';
import 'package:vignesh_project_01/features/chat/presentation/widgets/message_status_icon.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message});

  final MessageEntity message;

  @override
  Widget build(BuildContext context) {
    final chatColors = context.chatColors;
    final isMe = message.isSentByMe;
    final big = Radius.circular(16.r);
    final small = Radius.circular(4.r);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,

      child: Container(
        constraints: BoxConstraints(maxWidth: 0.7.sw),
        margin: EdgeInsets.only(top: 5.h),
        padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 8.h),
        decoration: ShapeDecoration(
          gradient: isMe ? chatColors.sentBubbleGradient : null,
          color: isMe ? null : chatColors.receivedBubble,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: big,
              topRight: big,
              bottomLeft: isMe ? big : small,
              bottomRight: isMe ? small : big,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: .min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: Text(
                message.content ?? "",
                style: context.textTheme.bodyLarge?.copyWith(
                  color: isMe
                      ? chatColors.onSentBubble
                      : chatColors.onReceivedBubble,
                ),
              ),
            ),
            SizedBox(width: 6.w),
            Text(
              (message.createdAt ?? DateTime.now()).toLocal().timeFormat(),
              style: context.textTheme.labelSmall?.copyWith(
                color: isMe
                    ? chatColors.onSentBubbleMuted
                    : chatColors.onReceivedBubbleMuted,
              ),
            ),
            if (isMe) SizedBox(width: 4.w),
            if (isMe)
              MessageStatusIcon(
                status: message.status ?? MessageStatus.pending,
              ),
          ],
        ),
      ),
    );
  }
}

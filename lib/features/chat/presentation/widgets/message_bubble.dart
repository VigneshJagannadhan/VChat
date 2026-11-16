import 'package:flutter/material.dart';
import 'package:vignesh_project_01/core/extensions/date_time_extensions.dart';
import 'package:vignesh_project_01/core/extensions/theme_extensions.dart';
import 'package:vignesh_project_01/core/utils/enums.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/message_entity.dart';
import 'package:vignesh_project_01/features/chat/presentation/widgets/message_status_icon.dart';
import 'package:vignesh_project_01/core/themes/app_dimens.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/text/body_text.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/text/label_text.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message});

  final MessageEntity message;

  @override
  Widget build(BuildContext context) {
    final chatColors = context.chatColors;
    final isMe = message.isSentByMe;
    const big = Radius.circular(AppRadius.lg);
    const small = Radius.circular(AppRadius.sm);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,

      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.7,
        ),
        margin: const EdgeInsets.only(top: AppSpacing.xs),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
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
              child: BodyText.large(
                message.content ?? "",
                color: isMe
                    ? chatColors.onSentBubble
                    : chatColors.onReceivedBubble,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            LabelText.small(
              (message.createdAt ?? DateTime.now()).toLocal().timeFormat(),
              color: isMe
                  ? chatColors.onSentBubbleMuted
                  : chatColors.onReceivedBubbleMuted,
            ),
            if (isMe) const SizedBox(width: AppSpacing.xs),
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

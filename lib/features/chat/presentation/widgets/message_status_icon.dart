import 'package:flutter/material.dart';
import 'package:vignesh_project_01/core/extensions/theme_extensions.dart';
import 'package:vignesh_project_01/core/utils/enums.dart';
import 'package:vignesh_project_01/core/themes/app_dimens.dart';

/// Delivery status shown inside the current user's (sent) bubble.
class MessageStatusIcon extends StatelessWidget {
  const MessageStatusIcon({super.key, required this.status});

  final MessageStatus status;

  @override
  Widget build(BuildContext context) {
    final chatColors = context.chatColors;
    switch (status) {
      case MessageStatus.pending:
        return Icon(
          Icons.access_time_rounded,
          size: AppSizes.iconXs,
          color: chatColors.onSentBubbleMuted,
        );
      case MessageStatus.failed:
        return Icon(
          Icons.error_outline,
          size: AppSizes.iconXs,
          color: chatColors.sentBubbleError,
        );
      case MessageStatus.success:
        return Icon(
          Icons.check_circle,
          size: AppSizes.iconXs,
          color: chatColors.onSentBubble,
        );
    }
  }
}

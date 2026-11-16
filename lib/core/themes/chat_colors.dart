import 'package:flutter/material.dart';
import 'package:vignesh_project_01/core/themes/app_colors.dart';

/// Chat-specific colors that have no matching [ColorScheme] role.
///
/// Read via `context.chatColors`.
@immutable
class ChatColors extends ThemeExtension<ChatColors> {
  const ChatColors({
    required this.sentBubbleGradient,
    required this.onSentBubble,
    required this.onSentBubbleMuted,
    required this.sentBubbleError,
    required this.receivedBubble,
    required this.onReceivedBubble,
    required this.onReceivedBubbleMuted,
    required this.online,
    required this.success,
  });

  /// Background of the current user's bubbles and the send button.
  final Gradient sentBubbleGradient;
  final Color onSentBubble;

  /// Timestamp and status icons on a sent bubble.
  final Color onSentBubbleMuted;

  /// Failed-status icon on a sent bubble.
  final Color sentBubbleError;

  final Color receivedBubble;
  final Color onReceivedBubble;

  /// Timestamp on a received bubble.
  final Color onReceivedBubbleMuted;

  final Color online;
  final Color success;

  static const ChatColors dark = ChatColors(
    sentBubbleGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColors.violet, AppColors.pinkViolet],
    ),
    onSentBubble: AppColors.white,
    // Full white on purpose: any alpha drops the 10sp timestamp below 4.5:1
    // on the pink end of the gradient. Hierarchy comes from size instead.
    onSentBubbleMuted: AppColors.white,
    sentBubbleError: AppColors.errorOnViolet,
    receivedBubble: AppColors.surfaceHigh,
    onReceivedBubble: AppColors.textPrimary,
    onReceivedBubbleMuted: AppColors.textSecondary,
    online: AppColors.success,
    success: AppColors.success,
  );

  @override
  ChatColors copyWith({
    Gradient? sentBubbleGradient,
    Color? onSentBubble,
    Color? onSentBubbleMuted,
    Color? sentBubbleError,
    Color? receivedBubble,
    Color? onReceivedBubble,
    Color? onReceivedBubbleMuted,
    Color? online,
    Color? success,
  }) {
    return ChatColors(
      sentBubbleGradient: sentBubbleGradient ?? this.sentBubbleGradient,
      onSentBubble: onSentBubble ?? this.onSentBubble,
      onSentBubbleMuted: onSentBubbleMuted ?? this.onSentBubbleMuted,
      sentBubbleError: sentBubbleError ?? this.sentBubbleError,
      receivedBubble: receivedBubble ?? this.receivedBubble,
      onReceivedBubble: onReceivedBubble ?? this.onReceivedBubble,
      onReceivedBubbleMuted:
          onReceivedBubbleMuted ?? this.onReceivedBubbleMuted,
      online: online ?? this.online,
      success: success ?? this.success,
    );
  }

  @override
  ChatColors lerp(ChatColors? other, double t) {
    if (other is! ChatColors) return this;
    return ChatColors(
      sentBubbleGradient: Gradient.lerp(
        sentBubbleGradient,
        other.sentBubbleGradient,
        t,
      )!,
      onSentBubble: Color.lerp(onSentBubble, other.onSentBubble, t)!,
      onSentBubbleMuted: Color.lerp(
        onSentBubbleMuted,
        other.onSentBubbleMuted,
        t,
      )!,
      sentBubbleError: Color.lerp(sentBubbleError, other.sentBubbleError, t)!,
      receivedBubble: Color.lerp(receivedBubble, other.receivedBubble, t)!,
      onReceivedBubble: Color.lerp(
        onReceivedBubble,
        other.onReceivedBubble,
        t,
      )!,
      onReceivedBubbleMuted: Color.lerp(
        onReceivedBubbleMuted,
        other.onReceivedBubbleMuted,
        t,
      )!,
      online: Color.lerp(online, other.online, t)!,
      success: Color.lerp(success, other.success, t)!,
    );
  }
}

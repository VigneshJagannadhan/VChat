import 'package:flutter/material.dart';
import 'package:vignesh_project_01/core/extensions/theme_extensions.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_detail/chat_detail_states.dart';
import 'package:vignesh_project_01/features/chat/presentation/widgets/message_bubble.dart';
import 'package:vignesh_project_01/features/chat/presentation/widgets/typing_message_bubble.dart';
import 'package:vignesh_project_01/core/themes/app_dimens.dart';
import 'package:vignesh_project_01/l10n/app_localizations.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/text/label_text.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key, required this.state});

  final ChatDetailLoaded state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            reverse: true,
            itemCount: state.messages.length,
            itemBuilder: (context, index) {
              final message = state.messages[index];
              final isLastItem = index == state.messages.length - 1;
              bool showDateHeader = false;

              if (isLastItem) {
                showDateHeader = true;
              } else {
                final nextMessage = state.messages[index + 1]; // Older message
                if (!_isSameDay(message.createdAt, nextMessage.createdAt)) {
                  showDateHeader = true;
                }
              }

              return Column(
                children: [
                  if (showDateHeader)
                    _buildDateHeader(context, message.createdAt),
                  MessageBubble(message: message),
                ],
              );
            },
          ),
        ),
        if (state.isTyping) const TypingMessageBubble(),
      ],
    );
  }

  bool _isSameDay(DateTime? date1, DateTime? date2) {
    if (date1 == null || date2 == null) return false;
    final d1 = date1.toLocal();
    final d2 = date2.toLocal();
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  Widget _buildDateHeader(BuildContext context, DateTime? date) {
    if (date == null) return const SizedBox.shrink();
    final localDate = date.toLocal();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final headerDate = DateTime(localDate.year, localDate.month, localDate.day);

    final l10n = AppLocalizations.of(context)!;
    String text;
    if (headerDate == today) {
      text = l10n.todayLabel;
    } else if (headerDate == yesterday) {
      text = l10n.yesterdayLabel;
    } else {
      // Simple date format: DD/MM/YYYY
      text = '${localDate.day}/${localDate.month}/${localDate.year}';
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: ShapeDecoration(
        color: context.colors.surfaceContainerHighest,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),
      child: LabelText.medium(text),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vignesh_project_01/core/di/locator.dart';
import 'package:vignesh_project_01/core/services/socket_service.dart';
import 'package:vignesh_project_01/core/themes/app_dimens.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_detail/chat_detail_cubit.dart';
import 'package:vignesh_project_01/features/chat/presentation/widgets/send_message_button.dart';
import 'package:vignesh_project_01/l10n/app_localizations.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_text_field.dart';

class ChatViewBottomNav extends StatefulWidget {
  const ChatViewBottomNav({
    super.key,
    required this.messageController,
    required this.chatId,
  });
  final TextEditingController messageController;
  final String? chatId;

  @override
  State<ChatViewBottomNav> createState() => _ChatViewBottomNavState();
}

class _ChatViewBottomNavState extends State<ChatViewBottomNav> {
  final SocketService _socketService = locator<SocketService>();
  final ValueNotifier<bool> _hasText = ValueNotifier<bool>(false);
  Timer? _typingTimer;
  bool _isTyping = false;

  @override
  void dispose() {
    _stopTyping();
    _hasText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: null,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),
      child: ValueListenableBuilder(
        valueListenable: _hasText,
        builder: (context, hasText, child) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: AppTextField(
                  controller: widget.messageController,
                  hint: AppLocalizations.of(context)!.messageHint,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  minLines: 1,
                  maxLines: 5,
                  autovalidateMode: AutovalidateMode.disabled,
                  onChanged: _onChanged,
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 100),
                transitionBuilder: (child, animation) => SizeTransition(
                  sizeFactor: animation,
                  axis: Axis.horizontal,
                  alignment: AlignmentDirectional.centerStart,
                  child: child,
                ),
                // Send only once the chat has loaded, so the message has a
                // list to appear in.
                child:
                    hasText &&
                        context.select<ChatDetailCubit, bool>(
                          (cubit) => cubit.canSend,
                        )
                    // Counts as part of the text field, so tapping send
                    // doesn't dismiss the keyboard.
                    ? TextFieldTapRegion(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                            start: AppSpacing.sm,
                          ),
                          child: SendMessageButton(onTap: _sendMessage),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onChanged(String value) {
    _hasText.value = value.trim().isNotEmpty;

    if (!_isTyping) {
      _socketService.startTyping(widget.chatId ?? '');
      _isTyping = true;
    }
    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(seconds: 1), _stopTyping);
  }

  void _stopTyping() {
    _typingTimer?.cancel();
    if (!_isTyping) return;
    _isTyping = false;
    _socketService.stopTyping(widget.chatId ?? '');
  }

  void _sendMessage() {
    final content = widget.messageController.text;
    if (content.trim().isEmpty) return;

    // Clear right away so a slow request can't be sent twice; a failed
    // message stays in the list with a retry action instead.
    widget.messageController.clear();
    _hasText.value = false;
    _stopTyping();

    context.read<ChatDetailCubit>().sendMessage(
      chatId: widget.chatId ?? '',
      content: content,
    );
  }
}

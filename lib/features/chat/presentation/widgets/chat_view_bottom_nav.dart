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
  Timer? _debounce;
  bool _isTyping = false;
  ValueNotifier<bool> isNotEmpty = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: null,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),
      child: ValueListenableBuilder(
        valueListenable: isNotEmpty,
        builder: (context, notEmpty, child) {
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
                child: notEmpty
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

  void _onChanged(String? value) {
    _debounce?.cancel();
    var socketService = locator<SocketService>();

    if (value?.isNotEmpty ?? false) {
      isNotEmpty.value = true;
    } else {
      isNotEmpty.value = false;
    }

    if (!_isTyping) {
      socketService.startTyping(widget.chatId ?? "");
      _isTyping = true;
    }

    _debounce = Timer(const Duration(seconds: 1), () {
      _isTyping = false;
      socketService.stopTyping(widget.chatId ?? "");
    });
  }

  void _sendMessage() {
    var read = context.read<ChatDetailCubit>();
    read
        .sendMessage(
          userId: widget.chatId ?? '',
          content: widget.messageController.text,
        )
        .then((_) {
          widget.messageController.clear();
          isNotEmpty.value = false;
        });
  }
}

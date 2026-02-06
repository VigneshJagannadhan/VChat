import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vignesh_project_01/core/di/locator.dart';
import 'package:vignesh_project_01/core/services/socket_service.dart';
import 'package:vignesh_project_01/core/themes/app_colors.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_detail/chat_detail_cubit.dart';
import 'package:vignesh_project_01/features/chat/presentation/widgets/send_message_button.dart';
import 'package:vk_custom_widgets/vk_custom_widgets.dart';

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
      color: AppColors.darkBackground,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: ValueListenableBuilder(
          valueListenable: isNotEmpty,
          builder: (context, notEmpty, child) {
            return Row(
              children: [
                Expanded(
                  child: VkTextFormField(
                    controller: widget.messageController,
                    label: '',
                    borderWidth: 0.1.r,
                    borderRadius: 20.r,
                    onChanged: _onChanged,
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 100),
                  transitionBuilder: (child, animation) => SizeTransition(
                    sizeFactor: animation,
                    axis: Axis.horizontal,
                    axisAlignment: -1.0,
                    child: child,
                  ),
                  child: notEmpty
                      ? Row(
                          children: [
                            SizedBox(width: 10.w),
                            SendMessageButton(onTap: _sendMessage),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            );
          },
        ),
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

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vignesh_project_01/core/di/locator.dart';
import 'package:vignesh_project_01/core/services/socket_service.dart';
import 'package:vignesh_project_01/features/chat/data/models/message/message_model.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_detail/chat_detail_cubit.dart';
import 'package:vignesh_project_01/features/chat/presentation/widgets/chat_view_appbar.dart';
import 'package:vignesh_project_01/features/chat/presentation/widgets/chat_view_bottom_nav.dart';
import 'package:vignesh_project_01/features/chat/presentation/widgets/chat_view_message_body.dart';

class ChatView extends StatefulWidget {
  static const String route = '/chat_view';
  const ChatView({super.key, required this.chatId});

  final String? chatId;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _messageController = TextEditingController();
  ChatDetailCubit? _chatDetailCubit;
  SocketService socketService = locator<SocketService>();

  void Function()? _messageListenerResult;
  void Function()? _typingListenerResult;
  void Function()? _stopTypingListenerResult;

  @override
  void initState() {
    super.initState();
    socketService.joinChat(widget.chatId ?? '');

    _chatDetailCubit = context.read<ChatDetailCubit>();

    _chatDetailCubit?.currentChatRoomId = widget.chatId;

    _messageListenerResult = socketService.onMessageReceived((data) {
      try {
        final entity = MessageModel.fromJson(data).toEntity();
        _chatDetailCubit?.addIncomingMessage(entity);
      } catch (e, stack) {
        log('❌ Error processing message: $e\n$stack');
      }
    });

    _typingListenerResult = socketService.onTyping((data) {
      _chatDetailCubit?.typingStatus(isTyping: true, chatRoomId: data ?? '');
    });

    _stopTypingListenerResult = socketService.onStopTyping((data) {
      _chatDetailCubit?.typingStatus(isTyping: false, chatRoomId: data ?? '');
    });

    WidgetsBinding.instance.addPostFrameCallback((v) async {
      if (widget.chatId != null) {
        await _chatDetailCubit?.getChatDetail(id: widget.chatId!);
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _messageListenerResult?.call();
    _typingListenerResult?.call();
    _stopTypingListenerResult?.call();
    socketService.leaveChat(widget.chatId ?? '');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatViewAppBar(),
      body: Column(
        children: [
          Expanded(child: ChatViewMessageBody()),
          ChatViewBottomNav(
            messageController: _messageController,
            chatId: widget.chatId,
          ),
        ],
      ),
    );
  }
}

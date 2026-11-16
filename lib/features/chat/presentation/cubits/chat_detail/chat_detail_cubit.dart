import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vignesh_project_01/core/utils/enums.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/message_entity.dart';
import 'package:vignesh_project_01/features/chat/domain/repositories/chat_repository.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_detail/chat_detail_states.dart';

class ChatDetailCubit extends Cubit<ChatDetailState> {
  final ChatRepository chatRepository;

  ChatDetailCubit({required this.chatRepository})
    : super(const ChatDetailInitial()) {
    log('ChatDetailCubit created: $hashCode');
  }

  String? currentChatRoomId;

  Future<void> getChatDetail({required String id}) async {
    emit(const ChatDetailLoading());

    final localResult = chatRepository.getChatDetail(id: id);
    localResult.fold((failure) => null, (response) {
      emit(
        ChatDetailLoaded(
          messages: response.messages?.reversed.toList() ?? [],
          isTyping: false,
          isSyncing: true,
        ),
      );
    });

    final syncResult = await chatRepository.syncChatDetail(id: id);

    syncResult.fold(
      (failure) {
        if (state is! ChatDetailLoaded) {
          emit(ChatDetailFailure(failure));
        }
      },
      (response) {
        emit(
          ChatDetailLoaded(
            // Keep messages the server doesn't have yet, so a sync that
            // finishes mid-send doesn't make them disappear.
            messages: [..._unsentMessages(), ...?response.messages?.reversed],
            isTyping: false,
            isSyncing: false,
          ),
        );
      },
    );
  }

  List<MessageEntity> _unsentMessages() {
    final current = state;
    if (current is! ChatDetailLoaded) return const [];
    return current.messages
        .where(
          (m) =>
              m.status == MessageStatus.pending ||
              m.status == MessageStatus.failed,
        )
        .toList();
  }

  void addIncomingMessage(MessageEntity data) {
    if (data.chatRoomId != currentChatRoomId) return;
    if (state is ChatDetailLoaded) {
      log('➕ Adding incoming message to list');
      final currentState = state as ChatDetailLoaded;
      final updatedMessages = List.of(currentState.messages)..insert(0, data);
      emit(
        ChatDetailLoaded(
          messages: updatedMessages,
          isTyping: false,
          isSyncing: false,
        ),
      );
    } else {
      log('⚠️ addIncomingMessage ignored: State is ${state.runtimeType}');
    }
  }

  void addOutgoingMessage(MessageEntity data) {
    final currentState = state;
    if (currentState is ChatDetailLoaded) {
      emit(
        ChatDetailLoaded(
          messages: [data, ...currentState.messages],
          isTyping: currentState.isTyping,
          isSyncing: currentState.isSyncing,
        ),
      );
    } else {
      log('⚠️ addOutgoingMessage ignored: State is ${state.runtimeType}');
    }
  }

  void typingStatus({required bool isTyping, required String chatRoomId}) {
    if (chatRoomId != currentChatRoomId) return;
    if (state is ChatDetailLoaded) {
      final currentState = state as ChatDetailLoaded;
      emit(
        ChatDetailLoaded(
          messages: currentState.messages,
          isTyping: isTyping,
          isSyncing: false,
        ),
      );
    }
  }

  /// Whether a message can be sent right now. Messages are only shown and
  /// tracked once the chat has loaded.
  bool get canSend => state is ChatDetailLoaded;

  /// Sends [content] to [chatId] with an optimistic pending bubble.
  /// Blank content, or a chat that hasn't loaded, is ignored.
  Future<void> sendMessage({
    required String chatId,
    required String content,
  }) async {
    final text = content.trim();
    if (text.isEmpty || !canSend) return;

    final pendingMessage = MessageEntity(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      chatRoomId: chatId,
      content: text,
      createdAt: DateTime.now(),
      isSentByMe: true,
      status: MessageStatus.pending,
    );
    addOutgoingMessage(pendingMessage);
    await _deliver(pendingMessage);
  }

  /// Resends a failed message, keeping its place in the list.
  Future<void> retryMessage(MessageEntity message) async {
    if (message.status != MessageStatus.failed) return;
    updateMessageStatus(messageId: message.id!, status: MessageStatus.pending);
    await _deliver(message);
  }

  Future<void> _deliver(MessageEntity message) async {
    final result = await chatRepository.sendMessage(
      userId: message.chatRoomId ?? currentChatRoomId ?? '',
      content: message.content ?? '',
    );
    updateMessageStatus(
      messageId: message.id!,
      status: result.isRight() ? MessageStatus.success : MessageStatus.failed,
    );
  }

  /// No-op if the chat isn't loaded (e.g. the user opened another chat
  /// while this message was in flight).
  void updateMessageStatus({
    required String messageId,
    required MessageStatus status,
    String? newServerId,
  }) {
    final currentState = state;
    if (currentState is! ChatDetailLoaded) return;

    emit(
      ChatDetailLoaded(
        messages: [
          for (final message in currentState.messages)
            message.id == messageId
                ? message.copyWith(
                    status: status,
                    id: newServerId ?? message.id,
                  )
                : message,
        ],
        isTyping: currentState.isTyping,
        isSyncing: currentState.isSyncing,
      ),
    );
  }

  void reset() {
    emit(const ChatDetailInitial());
  }
}

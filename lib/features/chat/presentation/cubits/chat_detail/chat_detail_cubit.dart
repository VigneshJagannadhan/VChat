import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vignesh_project_01/core/utils/enums.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/message_entity.dart';
import 'package:vignesh_project_01/features/chat/domain/repositories/chat_repository.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_detail/chat_detail_states.dart';

class ChatDetailCubit extends Cubit<ChatDetailState> {
  final ChatRepository chatRepository;

  ChatDetailCubit({required this.chatRepository}) : super(ChatDetailInitial()) {
    log('ChatDetailCubit created: $hashCode');
  }

  bool isTyping = false;
  String? currentChatRoomId;

  Future<void> getChatDetail({required String id}) async {
    emit(ChatDetailLoading());

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
            messages: response.messages?.reversed.toList() ?? [],
            isTyping: false,
            isSyncing: false,
          ),
        );
      },
    );
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
    if (state is ChatDetailLoaded) {
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

  Future<void> sendMessage({
    required String userId,
    required String content,
  }) async {
    final tempId = DateTime.now().millisecondsSinceEpoch.toString();

    MessageEntity pendingMessage = MessageEntity(
      id: tempId,
      content: content,
      createdAt: DateTime.now(),
      isSentByMe: true,
      status: MessageStatus.pending,
    );
    addOutgoingMessage(pendingMessage);
    final result = await chatRepository.sendMessage(
      userId: userId,
      content: content,
    );

    result.fold(
      (failure) {
        updateMessageStatus(messageId: tempId, status: MessageStatus.failed);
      },
      (data) {
        updateMessageStatus(messageId: tempId, status: MessageStatus.success);
      },
    );
  }

  void updateMessageStatus({
    required String messageId,
    required MessageStatus status,
    String? newServerId,
  }) {
    var currentState = state as ChatDetailLoaded;
    final updatedMessages = currentState.messages.map((message) {
      if (message.id == messageId) {
        return message.copyWith(status: status, id: newServerId ?? message.id);
      }
      return message;
    }).toList();

    emit(
      ChatDetailLoaded(
        messages: updatedMessages,
        isTyping: isTyping,
        isSyncing: false,
      ),
    );
  }

  void reset() {
    emit(ChatDetailInitial());
  }
}

import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final result = await chatRepository.getChatDetail(id: id);

    result.fold((failure) => emit(ChatDetailFailure(failure)), (response) {
      emit(ChatDetailLoaded(response.messages?.reversed.toList() ?? []));
    });
  }

  void addIncomingMessage(MessageEntity data) {
    if (data.chatRoomId != currentChatRoomId) return;
    if (state is ChatDetailLoaded) {
      log('➕ Adding incoming message to list');
      final currentState = state as ChatDetailLoaded;
      final updatedMessages = List.of(currentState.messages)..insert(0, data);
      emit(ChatDetailLoaded(updatedMessages));
    } else {
      log('⚠️ addIncomingMessage ignored: State is ${state.runtimeType}');
    }
  }

  void addOutgoingMessage(MessageEntity data) {
    if (state is ChatDetailLoaded) {
      log('➕ Adding Outgoing message to list');
      final currentState = state as ChatDetailLoaded;
      final updatedMessages = List.of(currentState.messages)..insert(0, data);
      emit(ChatDetailLoaded(updatedMessages));
    } else {
      log('⚠️ addOutgoingMessage ignored: State is ${state.runtimeType}');
    }
  }

  void typingStatus({required bool isTyping, required String chatRoomId}) {
    if (chatRoomId != currentChatRoomId) return;
    if (state is ChatDetailLoaded) {
      final currentState = state as ChatDetailLoaded;
      emit(ChatDetailLoaded(currentState.messages, isTyping: isTyping));
    }
  }

  Future<void> sendMessage({
    required String userId,
    required String content,
  }) async {
    final result = await chatRepository.sendMessage(
      userId: userId,
      content: content,
    );

    result.fold(
      (failure) {
        emit(ChatDetailFailure(failure));
      },
      (data) {
        MessageEntity message = MessageEntity(
          id: '',
          content: content,
          createdAt: DateTime.now(),
          isSentByMe: true,
        );
        addOutgoingMessage(message);
      },
    );
  }

  void reset() {
    emit(ChatDetailInitial());
  }
}

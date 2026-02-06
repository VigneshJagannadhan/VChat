import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vignesh_project_01/features/chat/domain/repositories/chat_repository.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_list/chat_list_states.dart';

class ChatCubit extends Cubit<ChatListState> {
  final ChatRepository chatRepository;

  ChatCubit({required this.chatRepository}) : super(ChatListInitial());

  Future<void> getChatList({String? search}) async {
    emit(ChatListLoading());

    final result = chatRepository.getChatList(search: search);

    result.fold((failure) => null, (response) {
      emit(ChatListLoaded(isSyncing: true, chats: response.chats ?? []));
    });

    var syncResult = await chatRepository.syncChatList();

    syncResult.fold(
      (failure) {
        if (state is ChatListLoaded) {
          final currentState = state as ChatListLoaded;
          emit(ChatListLoaded(isSyncing: false, chats: currentState.chats));
        } else {
          emit(ChatListFailure(failure));
        }
      },
      (response) {
        emit(ChatListLoaded(isSyncing: false, chats: response.chats ?? []));
      },
    );
  }

  Future<String> getChatRoomId({required String id}) async {
    String chatRoomId = '';
    final result = await chatRepository.getChatRoomId(id: id);

    result.fold((failure) => emit(ChatListFailure(failure)), (response) {
      chatRoomId = response.id ?? '';
    });
    return chatRoomId;
  }

  void reset() {
    emit(ChatListInitial());
  }
}

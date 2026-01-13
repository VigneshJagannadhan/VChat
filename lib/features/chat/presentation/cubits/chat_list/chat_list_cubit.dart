import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vignesh_project_01/features/chat/domain/repositories/chat_repository.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_list/chat_list_states.dart';

class ChatCubit extends Cubit<ChatListState> {
  final ChatRepository chatRepository;

  ChatCubit({required this.chatRepository}) : super(ChatListInitial());

  Future<void> getChatList({String? search}) async {
    emit(ChatListLoading());
    final result = await chatRepository.getChatList(search: search);
    result.fold((failure) => emit(ChatListFailure(failure)), (response) {
      emit(ChatListLoaded(response.chats ?? []));
    });
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

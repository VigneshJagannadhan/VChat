import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vignesh_project_01/features/chat/domain/repositories/chat_repository.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_list/chat_list_states.dart';

class ChatCubit extends Cubit<ChatListState> {
  final ChatRepository chatRepository;

  ChatCubit({required this.chatRepository}) : super(ChatListInitial());

  /// Bumped on every [getChatList] call so results from an older, slower
  /// request can't overwrite newer ones.
  int _latestRequest = 0;

  /// Shows cached chats (filtered by [search]) immediately, then the
  /// server's results. Keeps the current list on screen while searching
  /// instead of switching to the full-screen loader.
  Future<void> getChatList({String? search}) async {
    final request = ++_latestRequest;

    chatRepository.getChatList(search: search).fold(
      (_) {
        if (state is! ChatListLoaded) emit(ChatListLoading());
      },
      (response) =>
          emit(ChatListLoaded(isSyncing: true, chats: response.chats ?? [])),
    );

    final syncResult = await chatRepository.syncChatList(search: search);
    if (request != _latestRequest) return;

    syncResult.fold(
      (failure) {
        final current = state;
        if (current is ChatListLoaded) {
          emit(ChatListLoaded(isSyncing: false, chats: current.chats));
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

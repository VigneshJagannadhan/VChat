import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/chat_entity.dart';

sealed class ChatListState {}

class ChatListInitial extends ChatListState {}

class ChatListLoading extends ChatListState {}

class ChatListLoaded extends ChatListState {
  final bool isSyncing;
  final List<ChatEntity> chats;
  ChatListLoaded({required this.isSyncing, required this.chats});
}

class ChatListFailure extends ChatListState {
  final Failure failure;
  ChatListFailure(this.failure);
}

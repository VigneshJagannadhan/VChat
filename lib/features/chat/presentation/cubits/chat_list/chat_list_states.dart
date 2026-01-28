import 'package:equatable/equatable.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/chat_entity.dart';

sealed class ChatListState extends Equatable {}

class ChatListInitial extends ChatListState {
  @override
  List<Object?> get props => [];
}

class ChatListLoading extends ChatListState {
  @override
  List<Object?> get props => [];
}

class ChatListLoaded extends ChatListState {
  final bool isSyncing;
  final List<ChatEntity> chats;
  ChatListLoaded({required this.isSyncing, required this.chats});

  @override
  List<Object?> get props => [isSyncing, chats];
}

class ChatListFailure extends ChatListState {
  final Failure failure;
  ChatListFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}

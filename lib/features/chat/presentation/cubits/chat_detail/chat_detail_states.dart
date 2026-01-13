import 'package:equatable/equatable.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/message_entity.dart';

sealed class ChatDetailState extends Equatable {
  const ChatDetailState();

  @override
  List<Object?> get props => [];
}

class ChatDetailInitial extends ChatDetailState {
  const ChatDetailInitial();
}

class ChatDetailLoading extends ChatDetailState {
  const ChatDetailLoading();
}

class ChatDetailLoaded extends ChatDetailState {
  final List<MessageEntity> messages;
  final bool isTyping;

  const ChatDetailLoaded(this.messages, {this.isTyping = false});

  @override
  List<Object?> get props => [messages, isTyping];
}

class ChatDetailFailure extends ChatDetailState {
  final Failure failure;

  const ChatDetailFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}

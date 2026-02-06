import 'package:equatable/equatable.dart';
import 'package:vignesh_project_01/core/utils/enums.dart';

class MessageEntity extends Equatable {
  final String? id;
  final String? chatRoomId;
  final String? content;
  final DateTime? createdAt;
  final MessageStatus? status;
  final bool isSentByMe;

  const MessageEntity({
    this.id,
    this.chatRoomId,
    this.content,
    this.createdAt,
    this.status,
    required this.isSentByMe,
  });

  @override
  List<Object?> get props => [
    id,
    chatRoomId,
    content,
    createdAt,
    status,
    isSentByMe,
  ];

  MessageEntity copyWith({
    String? id,
    String? chatRoomId,
    String? content,
    DateTime? createdAt,
    MessageStatus? status,
    bool? isSentByMe,
  }) {
    return MessageEntity(
      id: id ?? this.id,
      chatRoomId: chatRoomId ?? this.chatRoomId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      isSentByMe: isSentByMe ?? this.isSentByMe,
    );
  }
}

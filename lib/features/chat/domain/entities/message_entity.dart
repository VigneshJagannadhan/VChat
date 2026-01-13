import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String? id;
  final String? chatRoomId;
  final String? content;
  final DateTime? createdAt;
  final bool isSentByMe;

  const MessageEntity({
    this.id,
    this.chatRoomId,
    this.content,
    this.createdAt,
    required this.isSentByMe,
  });

  @override
  List<Object?> get props => [id];
}

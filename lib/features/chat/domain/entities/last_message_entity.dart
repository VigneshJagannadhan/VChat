import 'package:equatable/equatable.dart';

class LastMessageEntity extends Equatable {
  final String? id;
  final String? content;
  final DateTime? createdAt;
  final String? chat;

  const LastMessageEntity({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.chat,
  });

  @override
  List<Object?> get props => [id, content, createdAt, chat];
}

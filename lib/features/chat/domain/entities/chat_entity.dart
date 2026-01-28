import 'package:equatable/equatable.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/last_message_entity.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/participant_entity.dart';

class ChatEntity extends Equatable {
  final String? id;
  final ParticipantEntity? participant;
  final LastMessageEntity? lastMessage;

  const ChatEntity({this.id, this.participant, this.lastMessage});

  @override
  List<Object?> get props => [id, participant, lastMessage];
}

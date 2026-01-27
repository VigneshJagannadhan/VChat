import 'package:equatable/equatable.dart';
import 'package:vignesh_project_01/features/chat/data/models/last_message/last_message_model.dart';
import 'package:vignesh_project_01/features/chat/data/models/participant/participant_model.dart';

class ChatEntity extends Equatable {
  final String? id;
  final ParticipantModel? participant;
  final LastMessageModel? lastMessage;

  const ChatEntity({this.id, this.participant, this.lastMessage});

  @override
  List<Object?> get props => [id, participant, lastMessage];
}

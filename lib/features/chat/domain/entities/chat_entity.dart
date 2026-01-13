import 'package:vignesh_project_01/features/chat/data/models/last_message/last_message_model.dart';
import 'package:vignesh_project_01/features/chat/data/models/participant/participant_model.dart';

class ChatEntity {
  String? id;
  ParticipantModel? participant;
  LastMessageModel? lastMessage;

  ChatEntity({this.id, this.participant, this.lastMessage});
}

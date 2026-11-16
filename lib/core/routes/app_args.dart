import 'package:vignesh_project_01/features/chat/domain/entities/participant_entity.dart';

class ChatDetailViewArgs {
  final String? chatId;

  /// The other person in the chat, shown in the app bar.
  final ParticipantEntity? participant;

  ChatDetailViewArgs({required this.chatId, this.participant});
}

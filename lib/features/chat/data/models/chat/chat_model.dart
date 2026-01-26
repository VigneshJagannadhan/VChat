import 'package:json_annotation/json_annotation.dart';
import 'package:vignesh_project_01/features/chat/data/models/last_message/last_message_model.dart';
import 'package:vignesh_project_01/features/chat/data/models/participant/participant_model.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/chat_entity.dart';

part 'chat_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ChatModel {
  @JsonKey(name: '_id')
  String? id;
  List<ParticipantModel>? participants;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  LastMessageModel? lastMessage;

  ChatModel({
    this.id,
    this.participants,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.lastMessage,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);

  ChatEntity toEntity({required String userId}) {
    // Check if participants list exists and is not empty
    ParticipantModel? otherParticipant;
    if (participants != null && participants!.isNotEmpty) {
      // Find the first person who isn't me,
      // or default to the first person (me) if I'm alone.
      otherParticipant = participants!.firstWhere(
        (e) => e.id != userId,
        orElse: () => participants!.first,
      );
    }

    return ChatEntity(
      id: id,
      participant: otherParticipant,
      lastMessage: lastMessage,
    );
  }
}

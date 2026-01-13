import 'package:json_annotation/json_annotation.dart';
import 'package:vignesh_project_01/features/chat/data/models/last_message/last_message_model.dart';
import 'package:vignesh_project_01/features/chat/data/models/participant/participant_model.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/chat_entity.dart';

part 'chat_model.g.dart';

@JsonSerializable()
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

  ChatEntity toEntity() {
    return ChatEntity(
      id: id,
      participant: participants != null && participants!.isNotEmpty
          ? participants!.last
          : null,
      lastMessage: lastMessage,
    );
  }
}

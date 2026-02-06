import 'package:json_annotation/json_annotation.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/participant_entity.dart';

part 'participant_model.g.dart';

@JsonSerializable()
class ParticipantModel {
  @JsonKey(name: '_id')
  String? id;
  String? username;
  String? email;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ParticipantModel({
    this.id,
    this.username,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ParticipantModel.fromJson(Map<String, dynamic> json) =>
      _$ParticipantModelFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipantModelToJson(this);

  ParticipantEntity toEntity() =>
      ParticipantEntity(id: id, username: username, email: email);
}

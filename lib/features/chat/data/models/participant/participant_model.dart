import 'package:json_annotation/json_annotation.dart';

part 'participant_model.g.dart';

@JsonSerializable()
class ParticipantModel {
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
}

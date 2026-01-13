import 'package:json_annotation/json_annotation.dart';
import 'package:vignesh_project_01/features/chat/data/models/sender/sender_model.dart';

part 'last_message_model.g.dart';

@JsonSerializable()
class LastMessageModel {
  String? id;
  SenderModel? sender;
  String? content;
  String? chat;
  List<dynamic>? readBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  LastMessageModel({
    this.id,
    this.sender,
    this.content,
    this.chat,
    this.readBy,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory LastMessageModel.fromJson(Map<String, dynamic> json) =>
      _$LastMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$LastMessageModelToJson(this);
}

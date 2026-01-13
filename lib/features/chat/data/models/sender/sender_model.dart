import 'package:json_annotation/json_annotation.dart';
part 'sender_model.g.dart';

@JsonSerializable()
class SenderModel {
  String? id;
  String? username;
  String? email;

  SenderModel({this.id, this.username, this.email});

  factory SenderModel.fromJson(Map<String, dynamic> json) =>
      _$SenderModelFromJson(json);

  Map<String, dynamic> toJson() => _$SenderModelToJson(this);
}

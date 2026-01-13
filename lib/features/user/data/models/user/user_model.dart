import 'package:json_annotation/json_annotation.dart';
import 'package:vignesh_project_01/features/user/domain/entities/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: '_id')
  String? id;
  String? username;
  String? email;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  UserModel({
    this.id,
    this.username,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserEntity toEntity() => UserEntity(id: id, name: username, email: email);
}

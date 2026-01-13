import 'package:json_annotation/json_annotation.dart';
import 'package:vignesh_project_01/features/auth/domain/entities/auth_enitiy.dart';
part 'auth_model.g.dart';

@JsonSerializable()
class AuthModel {
  @JsonKey(name: '_id')
  String? id;
  String? username;
  String? email;
  String? token;

  AuthModel({this.id, this.username, this.email, this.token});

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthModelToJson(this);

  AuthEnitiy toEntity() => AuthEnitiy(id: id, token: token);
}

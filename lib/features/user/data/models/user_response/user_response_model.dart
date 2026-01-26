import 'package:json_annotation/json_annotation.dart';
import 'package:vignesh_project_01/features/user/data/models/user/user_model.dart';

part 'user_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserListResponseModel {
  List<UserModel>? users;
  int? page;
  int? pages;
  int? total;

  UserListResponseModel({this.users, this.page, this.pages, this.total});

  factory UserListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserListResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserListResponseModelToJson(this);
}

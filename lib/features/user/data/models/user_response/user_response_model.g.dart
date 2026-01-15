// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserListResponseModel _$UserListResponseModelFromJson(
  Map<String, dynamic> json,
) => UserListResponseModel(
  users: (json['users'] as List<dynamic>?)
      ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  page: (json['page'] as num?)?.toInt(),
  pages: (json['pages'] as num?)?.toInt(),
  total: (json['total'] as num?)?.toInt(),
);

Map<String, dynamic> _$UserListResponseModelToJson(
  UserListResponseModel instance,
) => <String, dynamic>{
  'users': instance.users,
  'page': instance.page,
  'pages': instance.pages,
  'total': instance.total,
};

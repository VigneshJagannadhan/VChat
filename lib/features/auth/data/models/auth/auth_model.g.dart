// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthModel _$AuthModelFromJson(Map<String, dynamic> json) => AuthModel(
  id: json['_id'] as String?,
  username: json['username'] as String?,
  email: json['email'] as String?,
  token: json['token'] as String?,
);

Map<String, dynamic> _$AuthModelToJson(AuthModel instance) => <String, dynamic>{
  '_id': instance.id,
  'username': instance.username,
  'email': instance.email,
  'token': instance.token,
};

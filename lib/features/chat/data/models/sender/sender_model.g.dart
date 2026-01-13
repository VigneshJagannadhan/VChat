// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sender_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SenderModel _$SenderModelFromJson(Map<String, dynamic> json) => SenderModel(
  id: json['id'] as String?,
  username: json['username'] as String?,
  email: json['email'] as String?,
);

Map<String, dynamic> _$SenderModelToJson(SenderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
    };

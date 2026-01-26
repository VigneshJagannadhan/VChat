// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
  id: json['_id'] as String?,
  sender: json['sender'] == null
      ? null
      : UserModel.fromJson(json['sender'] as Map<String, dynamic>),
  content: json['content'] as String?,
  chat: json['chat'] == null
      ? null
      : ChatModel.fromJson(json['chat'] as Map<String, dynamic>),
  readBy: (json['readBy'] as List<dynamic>?)?.map((e) => e as String).toList(),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  version: (json['__v'] as num?)?.toInt(),
);

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'sender': instance.sender?.toJson(),
      'content': instance.content,
      'chat': instance.chat?.toJson(),
      'readBy': instance.readBy,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.version,
    };

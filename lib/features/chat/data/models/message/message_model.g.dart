// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
  id: json['_id'] as String,
  sender: UserModel.fromJson(json['sender'] as Map<String, dynamic>),
  content: json['content'] as String,
  chat: ChatModel.fromJson(json['chat'] as Map<String, dynamic>),
  readBy: (json['readBy'] as List<dynamic>).map((e) => e as String).toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  version: (json['__v'] as num).toInt(),
);

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'sender': instance.sender,
      'content': instance.content,
      'chat': instance.chat,
      'readBy': instance.readBy,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.version,
    };

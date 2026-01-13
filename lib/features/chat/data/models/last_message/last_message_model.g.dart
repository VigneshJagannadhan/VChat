// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LastMessageModel _$LastMessageModelFromJson(Map<String, dynamic> json) =>
    LastMessageModel(
      id: json['id'] as String?,
      sender: json['sender'] == null
          ? null
          : SenderModel.fromJson(json['sender'] as Map<String, dynamic>),
      content: json['content'] as String?,
      chat: json['chat'] as String?,
      readBy: json['readBy'] as List<dynamic>?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: (json['v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LastMessageModelToJson(LastMessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender': instance.sender,
      'content': instance.content,
      'chat': instance.chat,
      'readBy': instance.readBy,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'v': instance.v,
    };

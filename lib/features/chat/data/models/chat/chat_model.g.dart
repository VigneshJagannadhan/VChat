// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => ChatModel(
  id: json['_id'] as String?,
  participants: (json['participants'] as List<dynamic>?)
      ?.map((e) => ParticipantModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  v: (json['v'] as num?)?.toInt(),
  lastMessage: json['lastMessage'] == null
      ? null
      : LastMessageModel.fromJson(json['lastMessage'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
  '_id': instance.id,
  'participants': instance.participants?.map((e) => e.toJson()).toList(),
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'v': instance.v,
  'lastMessage': instance.lastMessage?.toJson(),
};

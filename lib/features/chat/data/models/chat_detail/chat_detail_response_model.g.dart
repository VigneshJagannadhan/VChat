// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_detail_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatDetailResponseModel _$ChatDetailResponseModelFromJson(
  Map<String, dynamic> json,
) => ChatDetailResponseModel(
  messages: (json['messages'] as List<dynamic>)
      .map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  page: (json['page'] as num).toInt(),
  pages: (json['pages'] as num).toInt(),
  total: (json['total'] as num).toInt(),
);

Map<String, dynamic> _$ChatDetailResponseModelToJson(
  ChatDetailResponseModel instance,
) => <String, dynamic>{
  'messages': instance.messages?.map((e) => e.toJson()).toList(),
  'page': instance.page,
  'pages': instance.pages,
  'total': instance.total,
};

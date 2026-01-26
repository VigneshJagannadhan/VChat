import 'package:json_annotation/json_annotation.dart';
import 'package:vignesh_project_01/features/chat/data/models/message/message_model.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/chat_detail_entity.dart';

part 'chat_detail_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ChatDetailResponseModel {
  final List<MessageModel> messages;
  final int page;
  final int pages;
  final int total;

  const ChatDetailResponseModel({
    required this.messages,
    required this.page,
    required this.pages,
    required this.total,
  });

  factory ChatDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ChatDetailResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatDetailResponseModelToJson(this);

  ChatDetailEntity toEntity() {
    return ChatDetailEntity(
      messages: messages.map((message) => message.toEntity()).toList(),
      page: page,
      pages: pages,
      total: total,
    );
  }
}

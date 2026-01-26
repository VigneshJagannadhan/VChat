import 'package:json_annotation/json_annotation.dart';
import 'package:vignesh_project_01/features/chat/data/models/chat/chat_model.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/chat_response_entity.dart';

part 'chat_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ChatResponseModel {
  List<ChatModel>? chats;
  int? page;
  int? pages;
  int? total;

  ChatResponseModel({this.chats, this.page, this.pages, this.total});

  factory ChatResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ChatResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatResponseModelToJson(this);

  ChatResponseEntity toEntity() {
    return ChatResponseEntity(
      chats: chats?.map((chatModel) => chatModel.toEntity()).toList(),
      page: page,
      pages: pages,
      total: total,
    );
  }
}

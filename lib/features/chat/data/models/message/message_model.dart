import 'package:json_annotation/json_annotation.dart';
import 'package:vignesh_project_01/core/di/locator.dart';
import 'package:vignesh_project_01/core/services/storage_service.dart';
import 'package:vignesh_project_01/core/utils/enums.dart';
import 'package:vignesh_project_01/features/chat/data/models/chat/chat_model.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/message_entity.dart';
import 'package:vignesh_project_01/features/user/data/models/user/user_model.dart';

part 'message_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MessageModel {
  @JsonKey(name: '_id')
  final String? id;
  final UserModel? sender;
  final String? content;
  final ChatModel? chat;
  final List<String>? readBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  @JsonKey(name: '__v')
  final int? version;

  const MessageModel({
    this.id,
    this.sender,
    this.content,
    this.chat,
    this.readBy,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);

  MessageEntity toEntity({required bool isFromApi}) {
    StorageService storageService = locator<StorageService>();
    var myId = storageService.fetchUserId();
    if (myId == null) {
      /// We need to log out the user
    }
    return MessageEntity(
      id: id,
      chatRoomId: chat?.id,
      content: content,
      createdAt: createdAt,
      isSentByMe: sender?.id == myId,
      status: isFromApi ? MessageStatus.success : MessageStatus.pending,
    );
  }
}

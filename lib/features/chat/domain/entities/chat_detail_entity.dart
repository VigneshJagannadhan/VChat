import 'package:vignesh_project_01/features/chat/domain/entities/message_entity.dart';

class ChatDetailEntity {
  List<MessageEntity>? messages;
  int? page;
  int? pages;
  int? total;

  ChatDetailEntity({this.messages, this.page, this.pages, this.total});
}

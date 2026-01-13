import 'package:vignesh_project_01/features/chat/domain/entities/chat_entity.dart';

class ChatResponseEntity {
  List<ChatEntity>? chats;
  int? page;
  int? pages;
  int? total;

  ChatResponseEntity({this.chats, this.page, this.pages, this.total});
}

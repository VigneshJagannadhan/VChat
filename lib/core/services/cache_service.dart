import 'package:vignesh_project_01/features/chat/domain/entities/chat_entity.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/message_entity.dart';

class CacheService {
  void initialise() {
    // initialise hive here
  }

  void saveChatList({required List<ChatEntity> chatList}) {
    // save the chat list to hive
  }

  void fetchChatList() {
    // fetch the chat list from hive
  }

  void clearChatList() {
    // clear the chat list from hive
  }

  void saveChatDetail({
    required String chatRoomId,
    required List<MessageEntity> chatDetail,
  }) {
    // save the chat detail to hive
  }

  void fetchChatDetail({required String chatRoomId}) {
    // fetch the chat detail from hive
  }

  void clearChatDetail() {
    // clear the chat detail from hive
  }
}

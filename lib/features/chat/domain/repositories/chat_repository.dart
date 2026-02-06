import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/features/chat/data/models/chat_response/chat_response_model.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/chat_detail_entity.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/chat_entity.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/chat_response_entity.dart';

abstract class ChatRepository {
  /// CHAT LIST
  Either<Failure, ChatResponseEntity> getChatList({String? search});
  Future<Either<Failure, ChatResponseEntity>> syncChatList({String? search});

  /// CHAT ROOM ID
  Future<Either<Failure, ChatEntity>> getChatRoomId({required String id});

  /// CHAT DETAIL
  Either<Failure, ChatDetailEntity> getChatDetail({required String id});
  Future<Either<Failure, ChatDetailEntity>> syncChatDetail({
    required String id,
  });

  /// SEND MESSAGE
  Future<Either<Failure, ChatResponseModel>> sendMessage({
    required String userId,
    required String content,
  });
}

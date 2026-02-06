import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/features/chat/data/models/chat/chat_model.dart';
import 'package:vignesh_project_01/features/chat/data/models/chat_detail/chat_detail_response_model.dart';
import 'package:vignesh_project_01/features/chat/data/models/chat_response/chat_response_model.dart';

abstract class ChatRemoteDataSource {
  /// ---------------------- CHAT LIST ----------------------
  Future<Either<Failure, ChatResponseModel>> getChatList({String? search});

  /// ---------------------- CHAT ROOM ID ----------------------
  Future<Either<Failure, ChatModel>> getChatRoomId({required String id});

  /// ---------------------- CHAT DETAIL ----------------------
  Future<Either<Failure, ChatDetailResponseModel>> getChatDetail({
    required String id,
  });

  /// ---------------------- SEND MESSAGE ----------------------
  Future<Either<Failure, ChatResponseModel>> sendMessage({
    required String userId,
    required String content,
  });
}

abstract class ChatLocalDataSource {
  /// ---------------------- CHAT LIST ----------------------
  Either<Failure, ChatResponseModel> getChatList();
  Future<void> saveChatList(ChatResponseModel chatResponseModel);

  /// ---------------------- CHAT DETAIL ----------------------
  Either<Failure, ChatDetailResponseModel> getChatDetail({required String id});
  Future<void> saveChatDetail({
    required String id,
    required ChatDetailResponseModel chatDetailResponseModel,
  });
}

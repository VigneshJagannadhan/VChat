import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/features/chat/data/models/chat/chat_model.dart';
import 'package:vignesh_project_01/features/chat/data/models/chat_detail/chat_detail_response_model.dart';
import 'package:vignesh_project_01/features/chat/data/models/chat_response/chat_response_model.dart';

abstract class ChatRemoteDataSource {
  Future<Either<Failure, ChatResponseModel>> getChatList({String? search});
  Future<Either<Failure, ChatModel>> getChatRoomId({required String id});
  Future<Either<Failure, ChatDetailResponseModel>> getChatDetail({
    required String id,
  });
  Future<Either<Failure, ChatResponseModel>> sendMessage({
    required String userId,
    required String content,
  });
}

abstract class ChatLocalDataSource {
  Either<Failure, ChatResponseModel> getChatList();
  Future<void> saveChatList(ChatResponseModel chatResponseModel);
}

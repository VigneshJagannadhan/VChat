import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/features/chat/data/data_sources/chat_data_sources.dart';
import 'package:vignesh_project_01/features/chat/data/models/chat_response/chat_response_model.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/chat_detail_entity.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/chat_entity.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/chat_response_entity.dart';
import 'package:vignesh_project_01/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl extends ChatRepository {
  ChatDataSources dataSources;
  ChatRepositoryImpl({required this.dataSources});

  @override
  Future<Either<Failure, ChatResponseEntity>> getChatList({
    String? search,
  }) async {
    var result = await dataSources.getChatList(search: search);
    return result.map((response) => response.toEntity());
  }

  @override
  Future<Either<Failure, ChatDetailEntity>> getChatDetail({
    required String id,
  }) async {
    var result = await dataSources.getChatDetail(id: id);
    return result.map((response) => response.toEntity());
  }

  @override
  Future<Either<Failure, ChatEntity>> getChatRoomId({
    required String id,
  }) async {
    var result = await dataSources.getChatRoomId(id: id);
    return result.map((response) => response.toEntity());
  }

  @override
  Future<Either<Failure, ChatResponseModel>> sendMessage({
    required String userId,
    required String content,
  }) async {
    var result = await dataSources.sendMessage(
      userId: userId,
      content: content,
    );
    return result.map((response) => response);
  }
}

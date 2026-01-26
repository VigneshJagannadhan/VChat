import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/di/locator.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/core/services/storage_service.dart';
import 'package:vignesh_project_01/features/chat/data/data_sources/chat_data_sources/chat_data_source.dart';
import 'package:vignesh_project_01/features/chat/data/models/chat_response/chat_response_model.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/chat_detail_entity.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/chat_entity.dart';
import 'package:vignesh_project_01/features/chat/domain/entities/chat_response_entity.dart';
import 'package:vignesh_project_01/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl extends ChatRepository {
  ChatRemoteDataSource chatRemoteDataSource;
  ChatLocalDataSource chatLocalDataSource;
  StorageService storageService;

  ChatRepositoryImpl({
    required this.chatRemoteDataSource,
    required this.chatLocalDataSource,
    required this.storageService,
  });

  String get _currentUserId => storageService.fetchUserId() ?? '';

  /// ---------------------- CHAT LIST ----------------------
  @override
  Either<Failure, ChatResponseEntity> getChatList({String? search}) {
    var result = chatLocalDataSource.getChatList();
    return result.fold((failure) => Left(failure), (response) {
      return Right(response.toEntity(userId: _currentUserId));
    });
  }

  @override
  Future<Either<Failure, ChatResponseEntity>> syncChatList({
    String? search,
  }) async {
    var result = await chatRemoteDataSource.getChatList(search: search);
    return result.fold((failure) => Left(failure), (response) async {
      await chatLocalDataSource.saveChatList(response);
      return Right(response.toEntity(userId: _currentUserId));
    });
  }

  /// ---------------------- CHAT DETAIL ----------------------

  @override
  Either<Failure, ChatDetailEntity> getChatDetail({required String id}) {
    var result = chatLocalDataSource.getChatDetail(id: id);
    return result.fold(
      (failure) => Left(failure),
      (response) => Right(response.toEntity()),
    );
  }

  @override
  Future<Either<Failure, ChatDetailEntity>> syncChatDetail({
    required String id,
  }) async {
    var result = await chatRemoteDataSource.getChatDetail(id: id);
    return result.fold((failure) async => Left(failure), (response) async {
      await chatLocalDataSource.saveChatDetail(
        id: id,
        chatDetailResponseModel: response,
      );
      return Right(response.toEntity());
    });
  }

  /// ---------------------- CHAT ROOM ID ----------------------
  @override
  Future<Either<Failure, ChatEntity>> getChatRoomId({
    required String id,
  }) async {
    var result = await chatRemoteDataSource.getChatRoomId(id: id);
    return result.map((response) {
      return response.toEntity(userId: _currentUserId);
    });
  }

  @override
  Future<Either<Failure, ChatResponseModel>> sendMessage({
    required String userId,
    required String content,
  }) async {
    var result = await chatRemoteDataSource.sendMessage(
      userId: userId,
      content: content,
    );
    return result.map((response) => response);
  }
}

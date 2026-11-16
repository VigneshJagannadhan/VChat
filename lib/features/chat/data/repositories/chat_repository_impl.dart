import 'package:fpdart/fpdart.dart';
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
      final entity = response.toEntity(userId: _currentUserId);
      final query = search?.trim().toLowerCase() ?? '';
      if (query.isEmpty) return Right(entity);

      // Same match as the backend: other participant's name contains query.
      entity.chats = entity.chats
          ?.where(
            (chat) => (chat.participant?.username?.toLowerCase() ?? '')
                .contains(query),
          )
          .toList();
      return Right(entity);
    });
  }

  @override
  Future<Either<Failure, ChatResponseEntity>> syncChatList({
    String? search,
  }) async {
    final query = search?.trim() ?? '';
    var result = await chatRemoteDataSource.getChatList(
      search: query.isEmpty ? null : query,
    );
    return result.fold((failure) => Left(failure), (response) async {
      // Only the unfiltered list is cached; search results would replace it.
      if (query.isEmpty) await chatLocalDataSource.saveChatList(response);
      return Right(response.toEntity(userId: _currentUserId));
    });
  }

  /// ---------------------- CHAT DETAIL ----------------------

  @override
  Either<Failure, ChatDetailEntity> getChatDetail({required String id}) {
    var result = chatLocalDataSource.getChatDetail(id: id);
    return result.fold(
      (failure) => Left(failure),
      (response) => Right(response.toEntity(isFromApi: true)),
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
      return Right(response.toEntity(isFromApi: true));
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

  ///  ---------------------- SEND A MESSAGE ----------------------

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

import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/constants/app_urls.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/core/services/api_service.dart';
import 'package:vignesh_project_01/core/utils/safe_parse.dart';
import 'package:vignesh_project_01/features/chat/data/data_sources/chat_data_sources/chat_data_source.dart';
import 'package:vignesh_project_01/features/chat/data/models/chat/chat_model.dart';
import 'package:vignesh_project_01/features/chat/data/models/chat_detail/chat_detail_response_model.dart';
import 'package:vignesh_project_01/features/chat/data/models/chat_response/chat_response_model.dart';

class ChatRemoteDataSourcesImpl extends ChatRemoteDataSource {
  ApiService apiService;
  ChatRemoteDataSourcesImpl({required this.apiService});

  @override
  Future<Either<Failure, ChatResponseModel>> getChatList({
    String? search,
  }) async {
    var result = await apiService.get(
      route: AppUrls.chats,
      query: search != null ? {'search': search} : null,
    );
    return result.fold(
      (error) => Left(error),
      (response) => safeParse(() => ChatResponseModel.fromJson(response.data)),
    );
  }

  @override
  Future<Either<Failure, ChatDetailResponseModel>> getChatDetail({
    required String id,
  }) async {
    var result = await apiService.get(route: '${AppUrls.chats}/$id/messages');
    return result.fold(
      (error) => Left(error),
      (response) =>
          safeParse(() => ChatDetailResponseModel.fromJson(response.data)),
    );
  }

  @override
  Future<Either<Failure, ChatModel>> getChatRoomId({required String id}) async {
    var result = await apiService.post(
      route: AppUrls.chats,
      data: {"userId": id},
    );
    return result.fold(
      (error) => Left(error),
      (response) => safeParse(() => ChatModel.fromJson(response.data)),
    );
  }

  @override
  Future<Either<Failure, ChatResponseModel>> sendMessage({
    required String userId,
    required String content,
  }) async {
    var result = await apiService.post(
      route: '${AppUrls.chats}/$userId/messages',
      data: {"content": content},
    );
    return result.map((response) => ChatResponseModel.fromJson(response.data));
  }
}

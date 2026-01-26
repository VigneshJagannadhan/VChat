import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/constants/app_urls.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/core/services/hive_service.dart';
import 'package:vignesh_project_01/features/chat/data/data_sources/chat_data_sources/chat_data_source.dart';
import 'package:vignesh_project_01/features/chat/data/models/chat_response/chat_response_model.dart';

class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  HiveService hiveService;

  ChatLocalDataSourceImpl({required this.hiveService});

  @override
  Either<Failure, ChatResponseModel> getChatList() {
    try {
      final result = hiveService.get(
        route: AppUrls.chats,
        box: HiveService.chatListBox,
      );
      if (result == null) {
        return Left(Failure(message: "No cache found"));
      }
      return Right(ChatResponseModel.fromJson(result));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<void> saveChatList(ChatResponseModel chatResponseModel) {
    return hiveService.save(
      route: AppUrls.chats,
      box: HiveService.chatListBox,
      value: chatResponseModel.toJson(),
    );
  }
}

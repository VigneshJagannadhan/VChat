import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/constants/app_urls.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/core/services/hive_service.dart';
import 'package:vignesh_project_01/features/user/data/data_sources/user_data_source/user_data_source.dart';
import 'package:vignesh_project_01/features/user/data/models/user/user_model.dart';
import 'package:vignesh_project_01/features/user/data/models/user_response/user_response_model.dart';

class UserLocalDataSourceImpl extends UserLocalDataSource {
  HiveService hiveService;

  UserLocalDataSourceImpl({required this.hiveService});

  @override
  Either<Failure, UserListResponseModel> getUserList({String? search}) {
    try {
      final result = hiveService.get(
        route: AppUrls.users,
        box: HiveService.userListBox,
      );
      if (result == null) {
        return Left(Failure(message: "No cache found"));
      }
      return Right(UserListResponseModel.fromJson(result));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<void> saveUserList(UserListResponseModel userListResponseModel) {
    return hiveService.save(
      route: AppUrls.users,
      box: HiveService.userListBox,
      value: userListResponseModel.toJson(),
    );
  }

  @override
  Either<Failure, UserModel> getProfileDetail() {
    try {
      final result = hiveService.get(
        route: AppUrls.profile,
        box: HiveService.profileBox,
      );
      if (result == null) {
        return Left(Failure(message: "No cache found"));
      }
      return Right(UserModel.fromJson(result));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<void> saveProfileDetail(UserModel userModel) {
    return hiveService.save(
      route: AppUrls.profile,
      box: HiveService.profileBox,
      value: userModel.toJson(),
    );
  }
}

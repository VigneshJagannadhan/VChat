import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/features/user/data/models/user/user_model.dart';
import 'package:vignesh_project_01/features/user/data/models/user_response/user_response_model.dart';

abstract class UserRemoteDataSources {
  Future<Either<Failure, UserListResponseModel>> getUserList({String? search});
  Future<Either<Failure, UserModel>> getProfileDetail();
}

abstract class UserLocalDataSource {
  Either<Failure, UserListResponseModel> getUserList({String? search});
  Future<void> saveUserList(UserListResponseModel userListResponseModel);

  Either<Failure, UserModel> getProfileDetail();
  Future<void> saveProfileDetail(UserModel userModel);
}

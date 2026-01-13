import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/features/user/data/models/user_response/user_response_model.dart';
import 'package:vignesh_project_01/features/user/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserListResponseModel>> getUserList({String? search});
  Future<Either<Failure, UserEntity>> getProfileDetail();
}

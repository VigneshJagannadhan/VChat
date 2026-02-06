import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/features/user/domain/entities/user_entity.dart';
import 'package:vignesh_project_01/features/user/domain/entities/user_list_response_enitity.dart';

abstract class UserRepository {
  Either<Failure, UserListResponseEntity> fetchUserList({String? search});
  Future<Either<Failure, UserListResponseEntity>> syncUserList({
    String? search,
  });

  Either<Failure, UserEntity> getProfileDetail();
  Future<Either<Failure, UserEntity>> syncProfileDetail();
}

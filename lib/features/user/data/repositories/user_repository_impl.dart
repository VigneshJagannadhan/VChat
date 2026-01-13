import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/features/user/data/data_sources/user_data_source.dart';
import 'package:vignesh_project_01/features/user/data/models/user_response/user_response_model.dart';
import 'package:vignesh_project_01/features/user/domain/entities/user_entity.dart';
import 'package:vignesh_project_01/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  UserDataSources dataSources;
  UserRepositoryImpl({required this.dataSources});

  @override
  Future<Either<Failure, UserListResponseModel>> getUserList({
    String? search,
  }) async {
    var result = await dataSources.getUserList(search: search);
    return result.map((response) => response);
  }

  @override
  Future<Either<Failure, UserEntity>> getProfileDetail() async {
    var result = await dataSources.getProfileDetail();
    return result.map((response) => response.toEntity());
  }
}

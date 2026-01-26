import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/features/user/data/data_sources/user_data_source/user_data_source.dart';
import 'package:vignesh_project_01/features/user/data/models/user_response/user_response_model.dart';
import 'package:vignesh_project_01/features/user/domain/entities/user_entity.dart';
import 'package:vignesh_project_01/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  UserRemoteDataSources remoteDataSource;
  UserLocalDataSource localDataSource;
  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Either<Failure, UserListResponseModel> fetchUserList({String? search}) {
    var result = localDataSource.getUserList(search: search);
    return result.fold(
      (failure) => Left(failure),
      (response) => Right(response),
    );
  }

  @override
  Future<Either<Failure, UserListResponseModel>> syncUserList({
    String? search,
  }) async {
    var result = await remoteDataSource.getUserList(search: search);
    return await result.fold((failure) async => Left(failure), (
      response,
    ) async {
      await localDataSource.saveUserList(response);
      return Right(response);
    });
  }

  @override
  Either<Failure, UserEntity> getProfileDetail() {
    var result = localDataSource.getProfileDetail();
    return result.fold(
      (failure) => Left(failure),
      (response) => Right(response.toEntity()),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> syncProfileDetail() async {
    var result = await remoteDataSource.getProfileDetail();
    return await result.fold((failure) async => Left(failure), (
      response,
    ) async {
      await localDataSource.saveProfileDetail(response);
      return Right(response.toEntity());
    });
  }
}

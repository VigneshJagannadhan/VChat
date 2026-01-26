import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/shared/data/data_sources/update/update_data_source.dart';
import 'package:vignesh_project_01/shared/domain/entities/update_entity.dart';
import 'package:vignesh_project_01/shared/domain/repositories/update_repository.dart';

class UpdateRepositoryImpl extends UpdateRepository {
  UpdateRemoteDataSource updateRemoteDataSource;
  UpdateLocalDataSource updateLocalDataSource;

  UpdateRepositoryImpl({
    required this.updateRemoteDataSource,
    required this.updateLocalDataSource,
  });

  @override
  Either<Failure, UpdateEntity> getCachedUpdate() {
    var result = updateLocalDataSource.checkForUpdate();
    return result.fold(
      (error) => Left(error),
      (updateModel) => Right(updateModel.toEntity()),
    );
  }

  @override
  Future<Either<Failure, UpdateEntity>> syncUpdate() async {
    var result = await updateRemoteDataSource.checkForUpdate();
    return result.fold((error) async => Left(error), (updateModel) async {
      await updateLocalDataSource.saveUpdate(updateModel: updateModel);
      return Right(updateModel.toEntity());
    });
  }
}

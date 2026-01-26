import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/shared/data/models/update_model.dart';

abstract class UpdateRemoteDataSource {
  Future<Either<Failure, UpdateModel>> checkForUpdate();
}

abstract class UpdateLocalDataSource {
  Either<Failure, UpdateModel> checkForUpdate();
  Future<void> saveUpdate({required UpdateModel updateModel});
}

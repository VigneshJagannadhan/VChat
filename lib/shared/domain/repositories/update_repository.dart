import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/shared/domain/entities/update_entity.dart';

abstract class UpdateRepository {
  Future<Either<Failure, UpdateEntity>> checkForUpdate();
}
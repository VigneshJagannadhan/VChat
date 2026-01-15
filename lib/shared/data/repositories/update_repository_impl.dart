import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/shared/data/data_sources/update_data_source.dart';
import 'package:vignesh_project_01/shared/domain/entities/update_entity.dart';
import 'package:vignesh_project_01/shared/domain/repositories/update_repository.dart';

class UpdateRepositoryImpl extends UpdateRepository {

  UpdateDataSource updateDataSource;

  UpdateRepositoryImpl({required this.updateDataSource});

  @override
  Future<Either<Failure, UpdateEntity>> checkForUpdate() async {
    var result = await updateDataSource.checkForUpdate();
    return result.map((response) => response.toEntity());
  }
}
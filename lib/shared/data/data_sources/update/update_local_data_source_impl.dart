import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/constants/app_urls.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/core/services/hive_service.dart';
import 'package:vignesh_project_01/shared/data/data_sources/update/update_data_source.dart';
import 'package:vignesh_project_01/shared/data/models/update_model.dart';

class UpdateLocalDataSourceImpl implements UpdateLocalDataSource {
  HiveService hiveService;

  UpdateLocalDataSourceImpl({required this.hiveService});

  @override
  Either<Failure, UpdateModel> checkForUpdate() {
    try {
      final result = hiveService.get(
        route: AppUrls.checkForUpdate,
        box: HiveService.appCacheBox,
      );
      if (result == null) {
        return Left(Failure(message: "No cache found"));
      }
      return Right(UpdateModel.fromJson(result));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<void> saveUpdate({required UpdateModel updateModel}) async {
    await hiveService.save(
      route: AppUrls.checkForUpdate,
      box: HiveService.appCacheBox,
      value: updateModel.toJson(),
    );
  }
}

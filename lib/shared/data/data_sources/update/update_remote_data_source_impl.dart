import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/constants/app_urls.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/core/services/api_service.dart';
import 'package:vignesh_project_01/shared/data/data_sources/update/update_data_source.dart';
import 'package:vignesh_project_01/shared/data/models/update_model.dart';

class UpdateRemoteDataSourceImpl implements UpdateRemoteDataSource {
  ApiService apiService;

  UpdateRemoteDataSourceImpl({required this.apiService});

  @override
  Future<Either<Failure, UpdateModel>> checkForUpdate() async {
    try {
      final result = await apiService.get(route: AppUrls.checkForUpdate);
      return result.map<UpdateModel>(
        (response) => UpdateModel.fromJson(response.data),
      );
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}

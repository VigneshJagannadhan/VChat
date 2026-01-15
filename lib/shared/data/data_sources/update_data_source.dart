import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/constants/app_urls.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/core/services/api_service.dart';
import 'package:vignesh_project_01/shared/data/models/update_model.dart';

abstract class UpdateDataSource {
  Future<Either<Failure, UpdateModel>> checkForUpdate();
}

class UpdateDataSourceImpl implements UpdateDataSource {
  ApiService apiService;

  UpdateDataSourceImpl({required this.apiService});

  @override
  Future<Either<Failure, UpdateModel>> checkForUpdate() async {
   try {
      final result = await apiService.get( route:  AppUrls.checkForUpdate);
      return result.map<UpdateModel>(
      (response) => UpdateModel.fromJson(response.data),
    );
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
   
  }
}
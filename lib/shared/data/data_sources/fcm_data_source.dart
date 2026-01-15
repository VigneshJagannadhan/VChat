import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/constants/app_urls.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/core/services/api_service.dart';

abstract class FcmDataSource {
  Future<Either<Failure, void>> saveToken({required String token});
  Future<Either<Failure, void>> removeToken();
}

class FcmDataSourceImpl implements FcmDataSource {
  final ApiService apiService;

  FcmDataSourceImpl({required this.apiService});

  @override
  Future<Either<Failure, void>> saveToken({required String token}) async {
    try {
      await apiService.post(route: AppUrls.fcmToken, data: {'token': token});
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeToken() async {
    try {
      await apiService.delete(route: AppUrls.fcmToken);
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}

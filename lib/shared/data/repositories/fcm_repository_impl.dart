import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/shared/data/data_sources/fcm_data_sources.dart';
import 'package:vignesh_project_01/shared/domain/repositories/fcm_repository.dart';

class FcmRepositoryImpl extends FcmRepository {
  final FcmDataSource fcmDataSource;

  FcmRepositoryImpl({required this.fcmDataSource});

  @override
  Future<Either<Failure, void>> removeToken() {
    return fcmDataSource.removeToken();
  }

  @override
  Future<Either<Failure, void>> saveToken({required String token}) {
    return fcmDataSource.saveToken(token: token);
  }
}

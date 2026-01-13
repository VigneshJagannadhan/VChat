import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/constants/app_urls.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/core/services/api_service.dart';
import 'package:vignesh_project_01/features/auth/data/models/auth/auth_model.dart';

abstract class AuthDataSource {
  Future<Either<Failure, AuthModel>> signUp({
    required Map<String, dynamic> userData,
  });
  Future<Either<Failure, AuthModel>> signIn({
    required Map<String, dynamic> userData,
  });
}

class AuthDataSourceImpl implements AuthDataSource {
  final ApiService apiService;

  AuthDataSourceImpl({required this.apiService});

  @override
  Future<Either<Failure, AuthModel>> signUp({
    required Map<String, dynamic> userData,
  }) async {
    var result = await apiService.post(route: AppUrls.signup, data: userData);
    return result.map<AuthModel>(
      (response) => AuthModel.fromJson(response.data),
    );
  }

  @override
  Future<Either<Failure, AuthModel>> signIn({
    required Map<String, dynamic> userData,
  }) async {
    var result = await apiService.post(route: AppUrls.signin, data: userData);
    return result.map<AuthModel>(
      (response) => AuthModel.fromJson(response.data),
    );
  }
}

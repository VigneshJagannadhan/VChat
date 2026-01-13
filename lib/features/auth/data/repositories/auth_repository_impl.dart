import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/features/auth/data/data_sources/auth_data_source.dart';
import 'package:vignesh_project_01/features/auth/data/models/auth/auth_model.dart';
import 'package:vignesh_project_01/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthDataSource authDataSource;
  AuthRepositoryImpl({required this.authDataSource});

  @override
  Future<Either<Failure, AuthModel>> signUp({
    required Map<String, dynamic> userData,
  }) async {
    var result = await authDataSource.signUp(userData: userData);
    return result.map((response) => response);
  }

  @override
  Future<Either<Failure, AuthModel>> signIn({
    required Map<String, dynamic> userData,
  }) async {
    var result = await authDataSource.signIn(userData: userData);
    return result.map((response) => response);
  }
}

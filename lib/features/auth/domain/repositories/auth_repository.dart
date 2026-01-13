import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/features/auth/data/models/auth/auth_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthModel>> signIn({
    required Map<String, dynamic> userData,
  });

  Future<Either<Failure, AuthModel>> signUp({
    required Map<String, dynamic> userData,
  });
}

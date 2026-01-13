import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';

abstract class FcmRepository {
  Future<Either<Failure, void>> saveToken({required String token});
  Future<Either<Failure, void>> removeToken();
}

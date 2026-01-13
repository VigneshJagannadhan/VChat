import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';

Either<Failure, T> safeParse<T>(
  T Function() parser, {
  String message = 'There was an error while parsing data',
}) {
  try {
    return Right(parser());
  } catch (e) {
    return Left(Failure(message: message));
  }
}

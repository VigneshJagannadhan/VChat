import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/features/user/domain/entities/user_entity.dart';

class UserStates {}

class UserIntial extends UserStates {}

class UserLoading extends UserStates {}

class UserLoaded extends UserStates {
  final UserEntity user;
  final bool isSyncing;
  UserLoaded({required this.user, required this.isSyncing});
}

class UserFailure extends UserStates {
  final Failure failure;

  UserFailure(this.failure);
}

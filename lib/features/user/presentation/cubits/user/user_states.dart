import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/features/user/domain/entities/user_entity.dart';

sealed class UserStates {}

class UserIntial extends UserStates {}

class UserLoading extends UserStates {}

class UserLoaded extends UserStates {
  final UserEntity user;
  final bool isSyncing;

  /// A profile update is in flight.
  final bool isSaving;

  /// Set when the last profile update failed; cleared on the next save.
  final Failure? saveFailure;

  UserLoaded({
    required this.user,
    required this.isSyncing,
    this.isSaving = false,
    this.saveFailure,
  });
}

class UserFailure extends UserStates {
  final Failure failure;

  UserFailure(this.failure);
}

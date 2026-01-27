import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/shared/domain/entities/update_entity.dart';

sealed class UpdateStates {}

class UpdateInitial extends UpdateStates {}

class UpdateLoading extends UpdateStates {}

class UpdateLoaded extends UpdateStates {
  final UpdateEntity updateEntity;
  final bool isUpdateAvailable;
  final bool isSyncing;
  UpdateLoaded({
    required this.updateEntity,
    required this.isUpdateAvailable,
    required this.isSyncing,
  });
}

class UpdateFailure extends UpdateStates {
  final Failure failure;
  UpdateFailure({required this.failure});
}

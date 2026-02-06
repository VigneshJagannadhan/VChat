import 'package:equatable/equatable.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/shared/domain/entities/update_entity.dart';

sealed class UpdateStates extends Equatable {}

class UpdateInitial extends UpdateStates {
  @override
  List<Object?> get props => [];
}

class UpdateLoading extends UpdateStates {
  @override
  List<Object?> get props => [];
}

class UpdateLoaded extends UpdateStates {
  final UpdateEntity updateEntity;
  final bool isUpdateAvailable;
  final bool isSyncing;
  UpdateLoaded({
    required this.updateEntity,
    required this.isUpdateAvailable,
    required this.isSyncing,
  });

  @override
  List<Object?> get props => [updateEntity, isUpdateAvailable, isSyncing];
}

class UpdateFailure extends UpdateStates {
  final Failure failure;
  UpdateFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}

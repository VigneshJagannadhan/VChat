import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/features/user/domain/entities/user_entity.dart';

sealed class UserListState {}

class UserListInitial extends UserListState {}

class UserListLoading extends UserListState {}

class UserListLoaded extends UserListState {
  final List<UserEntity> users;
  final bool isSyncing;
  UserListLoaded({required this.users, required this.isSyncing});
}

class UserListFailure extends UserListState {
  final Failure failure;
  UserListFailure(this.failure);
}

import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/features/user/data/models/user/user_model.dart';

sealed class UserListState {}

class UserListInitial extends UserListState {}

class UserListLoading extends UserListState {}

class UserListLoaded extends UserListState {
  final List<UserModel> users;
  final bool isSyncing;
  UserListLoaded({required this.users, required this.isSyncing});
}

class UserListFailure extends UserListState {
  final Failure failure;
  UserListFailure(this.failure);
}

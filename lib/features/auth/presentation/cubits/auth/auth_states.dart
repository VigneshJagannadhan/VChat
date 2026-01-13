import 'package:vignesh_project_01/core/exceptions/failure.dart';

sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthLoading extends AuthState {}

class AuthFailure extends AuthState {
  final Failure failure;
  AuthFailure({required this.failure});
}

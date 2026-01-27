import 'package:equatable/equatable.dart';
import 'package:vignesh_project_01/features/user/domain/entities/user_entity.dart';

class UserListResponseEntity extends Equatable {
  final List<UserEntity>? users;
  final int? page;
  final int? pages;
  final int? total;
  const UserListResponseEntity({this.users, this.page, this.pages, this.total});

  @override
  List<Object?> get props => [users, page, pages, total];
}

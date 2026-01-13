import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vignesh_project_01/features/user/domain/repositories/user_repository.dart';
import 'package:vignesh_project_01/features/user/presentation/cubits/user_list/user_list_states.dart';

class UserListCubit extends Cubit<UserListState> {
  final UserRepository userRepository;

  UserListCubit({required this.userRepository}) : super(UserListInitial());

  Future<void> findUsers({String? search}) async {
    emit(UserListLoading());

    final result = await userRepository.getUserList(search: search);

    result.fold((failure) => emit(UserListFailure(failure)), (response) {
      emit(UserListLoaded(response.users ?? []));
    });
  }

  void reset() {
    emit(UserListInitial());
  }
}

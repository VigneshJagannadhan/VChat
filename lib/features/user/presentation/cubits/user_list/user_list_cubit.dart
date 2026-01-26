import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vignesh_project_01/features/user/domain/repositories/user_repository.dart';
import 'package:vignesh_project_01/features/user/presentation/cubits/user_list/user_list_states.dart';

class UserListCubit extends Cubit<UserListState> {
  final UserRepository userRepository;

  UserListCubit({required this.userRepository}) : super(UserListInitial());

  Future<void> fetchUsers({String? search}) async {
    emit(UserListLoading());

    final localResult = userRepository.fetchUserList(search: search);

    localResult.fold((failure) => emit(UserListFailure(failure)), (response) {
      emit(UserListLoaded(response.users ?? []));
    });

    final result = await userRepository.syncUserList(search: search);

    result.fold(
      (failure) {
        if (state is! UserListLoaded) {
          emit(UserListFailure(failure));
        }
      },
      (response) {
        emit(UserListLoaded(response.users ?? []));
      },
    );
  }

  void reset() {
    emit(UserListInitial());
  }
}

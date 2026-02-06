import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vignesh_project_01/features/user/domain/repositories/user_repository.dart';
import 'package:vignesh_project_01/features/user/presentation/cubits/user/user_states.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit({required this.userRepository}) : super(UserIntial());

  UserRepository userRepository;

  void getUserDetail() async {
    emit(UserLoading());

    var localResult = userRepository.getProfileDetail();

    localResult.fold(
      (failure) => null,
      (response) => emit(UserLoaded(user: response, isSyncing: true)),
    );

    var result = await userRepository.syncProfileDetail();
    result.fold((error) {
      if (state is UserLoaded) {
        final currentState = state as UserLoaded;
        emit(UserLoaded(user: currentState.user, isSyncing: false));
      } else {
        emit(UserFailure(error));
      }
    }, (response) => emit(UserLoaded(user: response, isSyncing: false)));
  }
}

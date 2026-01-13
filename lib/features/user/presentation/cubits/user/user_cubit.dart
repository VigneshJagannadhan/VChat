import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vignesh_project_01/features/user/domain/repositories/user_repository.dart';
import 'package:vignesh_project_01/features/user/presentation/cubits/user/user_states.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit({required this.userRepository}) : super(UserIntial());

  UserRepository userRepository;

  void getUserDetail() async {
    emit(UserLoading());
    var result = await userRepository.getProfileDetail();
    result.fold(
      (error) => emit(UserFailure(error)),
      (response) => emit(UserLoaded(response)),
    );
  }
}

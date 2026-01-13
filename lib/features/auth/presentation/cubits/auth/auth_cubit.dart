import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:vignesh_project_01/core/di/locator.dart';
import 'package:vignesh_project_01/core/exceptions/failure.dart';
import 'package:vignesh_project_01/core/helpers/app_lifecycle_helper.dart';
import 'package:vignesh_project_01/core/helpers/navigation_helper.dart';
import 'package:vignesh_project_01/core/services/push_notification_service.dart';
import 'package:vignesh_project_01/core/services/socket_service.dart';
import 'package:vignesh_project_01/core/services/storage_service.dart';
import 'package:vignesh_project_01/features/auth/data/models/auth/auth_model.dart';
import 'package:vignesh_project_01/features/auth/domain/repositories/auth_repository.dart';
import 'package:vignesh_project_01/features/auth/presentation/cubits/auth/auth_states.dart';
import 'package:vignesh_project_01/features/chat/presentation/views/chat_list_view.dart';
import 'package:vignesh_project_01/shared/domain/repositories/fcm_repository.dart';
import 'package:vignesh_project_01/shared/others/popups/general_popup.dart';
import 'package:vignesh_project_01/shared/presentation/views/splash_view.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  final StorageService storageService;
  final SocketService socketService;

  AppLifecycleHelper? lifecycleHelper;

  AuthCubit({
    required this.fcmRepository,
    required this.authRepository,
    required this.storageService,
    required this.socketService,
  }) : super(AuthInitial());

  FcmRepository fcmRepository;

  Future<void> saveToken({required String token}) async {
    var result = await fcmRepository.saveToken(token: token);
    result.fold(
      (failure) => emit(AuthFailure(failure: failure)),
      (success) => emit(AuthSuccess()),
    );
  }

  Future<void> removeToken() async {
    var result = await fcmRepository.removeToken();
    result.fold(
      (failure) => emit(AuthFailure(failure: failure)),
      (success) => emit(AuthSuccess()),
    );
  }

  Future<void> _saveToken({
    required AuthModel response,
    required BuildContext context,
  }) async {
    await storageService.saveAccessToken(token: response.token ?? "");
    await storageService.saveRefreshToken(token: response.token ?? "");
    await storageService.saveUserId(id: response.id ?? "");
    await storageService.saveUserEmail(email: response.email ?? "");
    socketService.connect();
    var fcmToken = await locator<PushNotificationService>().getFcmToken();
    await saveToken(token: fcmToken ?? "");

    lifecycleHelper = AppLifecycleHelper();
    lifecycleHelper?.start();
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(AuthLoading());

    Either<Failure, AuthModel> authResponse = await authRepository.signUp(
      userData: {"username": name, "email": email, "password": password},
    );

    authResponse.fold((error) => emit(AuthFailure(failure: error)), (
      response,
    ) async {
      emit(AuthSuccess());
      await _saveToken(response: response, context: context);
      if (!context.mounted) return;
      bool? result = await showGeneralPopup(
        context: context,
        title: 'Successfully registered',
        message: '',
        confirmLabel: 'Go to Home screen',
        singleButton: true,
        barrierDismissible: false,
      );

      if (result ?? false) {
        if (!context.mounted) return;
        NavigationHelper.pushReplacementNamed(
          context: context,
          route: ChatListView.route,
        );
      }
    });
  }

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(AuthLoading());
    Either<Failure, AuthModel> authResponse = await authRepository.signIn(
      userData: {"email": email, "password": password},
    );

    authResponse.fold(
      (error) {
        emit(AuthFailure(failure: error));
      },
      (response) async {
        emit(AuthSuccess());
        await _saveToken(response: response, context: context);
        if (!context.mounted) return;
        NavigationHelper.pushReplacementNamed(
          context: context,
          route: ChatListView.route,
        );
      },
    );
  }

  Future<void> logout(BuildContext context) async {
    emit(AuthLoading());
    await removeToken();
    await storageService.clearAll();
    lifecycleHelper?.dispose();
    emit(AuthInitial());
    if (!context.mounted) return;
    NavigationHelper.pushReplacementNamed(
      context: context,
      route: SplashView.route,
    );
  }
}

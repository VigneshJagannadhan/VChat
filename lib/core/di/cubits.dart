import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vignesh_project_01/core/di/locator.dart';
import 'package:vignesh_project_01/core/services/hive_service.dart';
import 'package:vignesh_project_01/core/services/socket_service.dart';
import 'package:vignesh_project_01/core/services/storage_service.dart';
import 'package:vignesh_project_01/features/auth/domain/repositories/auth_repository.dart';
import 'package:vignesh_project_01/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:vignesh_project_01/features/chat/domain/repositories/chat_repository.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_detail/chat_detail_cubit.dart';
import 'package:vignesh_project_01/features/chat/presentation/cubits/chat_list/chat_list_cubit.dart';
import 'package:vignesh_project_01/features/user/domain/repositories/user_repository.dart';
import 'package:vignesh_project_01/features/user/presentation/cubits/user/user_cubit.dart';
import 'package:vignesh_project_01/features/user/presentation/cubits/user_list/user_list_cubit.dart';
import 'package:vignesh_project_01/shared/domain/repositories/fcm_repository.dart';
import 'package:vignesh_project_01/shared/domain/repositories/update_repository.dart';
import 'package:vignesh_project_01/shared/presentation/cubits/locale/locale_cubit.dart';
import 'package:vignesh_project_01/shared/presentation/cubits/update/update_cubit.dart';

List<BlocProvider> get cubits => [
  BlocProvider<AuthCubit>(
    create: (context) => AuthCubit(
      fcmRepository: locator<FcmRepository>(),
      authRepository: locator<AuthRepository>(),
      storageService: locator<StorageService>(),
      socketService: locator<SocketService>(),
      hiveService: locator<HiveService>(),
    ),
  ),

  BlocProvider<ChatCubit>(
    create: (context) => ChatCubit(chatRepository: locator<ChatRepository>()),
  ),

  BlocProvider<UserListCubit>(
    create: (context) =>
        UserListCubit(userRepository: locator<UserRepository>()),
  ),

  BlocProvider<ChatDetailCubit>(
    create: (context) =>
        ChatDetailCubit(chatRepository: locator<ChatRepository>()),
  ),

  BlocProvider<UserCubit>(
    create: (context) => UserCubit(userRepository: locator<UserRepository>()),
  ),

  BlocProvider<UpdateCubit>(
    create: (context) => UpdateCubit(
      updateRepository: locator<UpdateRepository>(),
      storageService: locator<StorageService>(),
    ),
  ),

  BlocProvider<LocaleCubit>(create: (context) => LocaleCubit()),
];

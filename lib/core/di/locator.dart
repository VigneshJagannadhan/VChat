import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:vignesh_project_01/core/services/api_service.dart';
import 'package:vignesh_project_01/core/services/hive_service.dart';
import 'package:vignesh_project_01/core/services/push_notification_service.dart';
import 'package:vignesh_project_01/core/services/socket_service.dart';
import 'package:vignesh_project_01/core/services/storage_service.dart';
import 'package:vignesh_project_01/core/services/update_service.dart';
import 'package:vignesh_project_01/features/auth/data/data_sources/auth_data_source.dart';
import 'package:vignesh_project_01/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:vignesh_project_01/features/auth/domain/repositories/auth_repository.dart';
import 'package:vignesh_project_01/features/chat/data/data_sources/chat_data_sources/chat_data_source.dart';
import 'package:vignesh_project_01/features/chat/data/data_sources/chat_data_sources/chat_local_data_source.dart';
import 'package:vignesh_project_01/features/chat/data/data_sources/chat_data_sources/chat_remote_data_source.dart';
import 'package:vignesh_project_01/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:vignesh_project_01/features/chat/domain/repositories/chat_repository.dart';
import 'package:vignesh_project_01/features/user/data/data_sources/user_data_source/user_data_source.dart';
import 'package:vignesh_project_01/features/user/data/data_sources/user_data_source/user_local_data_source.dart';
import 'package:vignesh_project_01/features/user/data/data_sources/user_data_source/user_remote_data_source.dart';
import 'package:vignesh_project_01/features/user/data/repositories/user_repository_impl.dart';
import 'package:vignesh_project_01/features/user/domain/repositories/user_repository.dart';
import 'package:vignesh_project_01/shared/data/data_sources/fcm_data_source.dart';
import 'package:vignesh_project_01/shared/data/data_sources/update/update_data_source.dart';
import 'package:vignesh_project_01/shared/data/data_sources/update/update_local_data_source_impl.dart';
import 'package:vignesh_project_01/shared/data/data_sources/update/update_remote_data_source_impl.dart';
import 'package:vignesh_project_01/shared/data/repositories/fcm_repository_impl.dart';
import 'package:vignesh_project_01/shared/data/repositories/update_repository_impl.dart';
import 'package:vignesh_project_01/shared/domain/repositories/fcm_repository.dart';
import 'package:vignesh_project_01/shared/domain/repositories/update_repository.dart';
import 'package:vignesh_project_01/shared/others/providers/token_provider.dart';

final locator = GetIt.instance;

void setupLocator() {
  /// SERVICES

  locator.registerLazySingleton(() => ApiService());

  locator.registerLazySingleton(() => HiveService());

  locator.registerLazySingleton(() => StorageService());

  locator.registerLazySingleton(() => SocketService());

  locator.registerLazySingleton(() => UpdateService());

  locator.registerLazySingleton<FirebaseMessaging>(
    () => FirebaseMessaging.instance,
  );

  locator.registerLazySingleton<FlutterLocalNotificationsPlugin>(
    () => FlutterLocalNotificationsPlugin(),
  );

  locator.registerLazySingleton(
    () => PushNotificationService(
      fcm: locator<FirebaseMessaging>(),
      localNotifications: locator<FlutterLocalNotificationsPlugin>(),
    ),
  );

  locator.registerLazySingleton<FcmDataSource>(
    () => FcmDataSourceImpl(apiService: locator<ApiService>()),
  );

  locator.registerLazySingleton<FcmRepository>(
    () => FcmRepositoryImpl(fcmDataSource: locator<FcmDataSource>()),
  );

  locator.registerLazySingleton<UpdateRepository>(
    () => UpdateRepositoryImpl(
      updateRemoteDataSource: locator<UpdateRemoteDataSource>(),
      updateLocalDataSource: locator<UpdateLocalDataSource>(),
    ),
  );

  locator.registerLazySingleton<UpdateRemoteDataSource>(
    () => UpdateRemoteDataSourceImpl(apiService: locator<ApiService>()),
  );

  locator.registerLazySingleton<UpdateLocalDataSource>(
    () => UpdateLocalDataSourceImpl(hiveService: locator<HiveService>()),
  );

  locator.registerLazySingleton<TokenProvider>(
    () => SecureTokenProvider(locator<StorageService>()),
  );

  locator.registerFactory<AuthDataSource>(
    () => AuthDataSourceImpl(apiService: locator<ApiService>()),
  );
  locator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(authDataSource: locator<AuthDataSource>()),
  );

  locator.registerFactory<ChatRemoteDataSource>(
    () => ChatRemoteDataSourcesImpl(apiService: locator<ApiService>()),
  );
  locator.registerFactory<ChatLocalDataSource>(
    () => ChatLocalDataSourceImpl(hiveService: locator<HiveService>()),
  );
  locator.registerFactory<ChatRepository>(
    () => ChatRepositoryImpl(
      chatRemoteDataSource: locator<ChatRemoteDataSource>(),
      chatLocalDataSource: locator<ChatLocalDataSource>(),
    ),
  );

  locator.registerFactory<UserRemoteDataSources>(
    () => UserRemoteDataSourcesImpl(apiService: locator<ApiService>()),
  );
  locator.registerFactory<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(hiveService: locator<HiveService>()),
  );
  locator.registerFactory<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: locator<UserRemoteDataSources>(),
      localDataSource: locator<UserLocalDataSource>(),
    ),
  );
}

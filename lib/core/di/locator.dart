import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:vignesh_project_01/core/services/api_service.dart';
import 'package:vignesh_project_01/core/services/push_notification_service.dart';
import 'package:vignesh_project_01/core/services/socket_service.dart';
import 'package:vignesh_project_01/core/services/storage_service.dart';
import 'package:vignesh_project_01/features/auth/data/data_sources/auth_data_source.dart';
import 'package:vignesh_project_01/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:vignesh_project_01/features/auth/domain/repositories/auth_repository.dart';
import 'package:vignesh_project_01/features/chat/data/data_sources/chat_data_sources.dart';
import 'package:vignesh_project_01/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:vignesh_project_01/features/chat/domain/repositories/chat_repository.dart';
import 'package:vignesh_project_01/features/user/data/data_sources/user_data_source.dart';
import 'package:vignesh_project_01/features/user/data/repositories/user_repository_impl.dart';
import 'package:vignesh_project_01/features/user/domain/repositories/user_repository.dart';
import 'package:vignesh_project_01/shared/data/data_sources/fcm_data_sources.dart';
import 'package:vignesh_project_01/shared/data/repositories/fcm_repository_impl.dart';
import 'package:vignesh_project_01/shared/domain/repositories/fcm_repository.dart';
import 'package:vignesh_project_01/shared/others/providers/token_provider.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => ApiService());

  locator.registerLazySingleton(() => StorageService());

  locator.registerLazySingleton(() => SocketService());

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

  locator.registerLazySingleton<TokenProvider>(
    () => SecureTokenProvider(locator<StorageService>()),
  );

  locator.registerFactory<AuthDataSource>(
    () => AuthDataSourceImpl(apiService: locator<ApiService>()),
  );
  locator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(authDataSource: locator<AuthDataSource>()),
  );

  locator.registerFactory<ChatDataSources>(
    () => ChatDataSourcesImpl(apiService: locator<ApiService>()),
  );
  locator.registerFactory<ChatRepository>(
    () => ChatRepositoryImpl(dataSources: locator<ChatDataSources>()),
  );

  locator.registerFactory<UserDataSources>(
    () => UserDataSourcesImpl(apiService: locator<ApiService>()),
  );
  locator.registerFactory<UserRepository>(
    () => UserRepositoryImpl(dataSources: locator<UserDataSources>()),
  );
}

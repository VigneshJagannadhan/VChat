import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vignesh_project_01/core/di/locator.dart';
import 'package:vignesh_project_01/core/di/cubits.dart';
import 'package:vignesh_project_01/core/helpers/firebase_background_handler.dart';
import 'package:vignesh_project_01/core/routes/app_routes.dart';
import 'package:vignesh_project_01/core/services/push_notification_service.dart';
import 'package:vignesh_project_01/core/services/socket_service.dart';
import 'package:vignesh_project_01/core/services/storage_service.dart';
import 'package:vignesh_project_01/core/themes/app_theme.dart';
import 'package:vignesh_project_01/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await locator<StorageService>().initialize();
  await locator<PushNotificationService>().initialize();
  locator<SocketService>().connect();
  runApp(const VigneshProject01());
}

class VigneshProject01 extends StatelessWidget {
  const VigneshProject01({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: cubits,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        child: MaterialApp(theme: theme, onGenerateRoute: onGenerateRoute),
      ),
    );
  }
}

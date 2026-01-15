import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vignesh_project_01/core/di/cubits.dart';
import 'package:vignesh_project_01/core/di/locator.dart';
import 'package:vignesh_project_01/core/helpers/firebase_background_handler.dart';
import 'package:vignesh_project_01/core/routes/app_routes.dart';
import 'package:vignesh_project_01/core/services/push_notification_service.dart';
import 'package:vignesh_project_01/core/services/socket_service.dart';
import 'package:vignesh_project_01/core/services/storage_service.dart';
import 'package:vignesh_project_01/core/themes/app_theme.dart';
import 'package:vignesh_project_01/firebase_options.dart';
import 'package:vignesh_project_01/l10n/app_localizations.dart';
import 'package:vignesh_project_01/shared/presentation/cubits/locale/locale_cubit.dart';
import 'package:vignesh_project_01/shared/presentation/cubits/locale/locale_states.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await dotenv.load(fileName: ".env");
  runApp(const VigneshProject01());
}

class VigneshProject01 extends StatefulWidget {
  const VigneshProject01({super.key});

  @override
  State<VigneshProject01> createState() => _VigneshProject01State();
}

class _VigneshProject01State extends State<VigneshProject01> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
      await locator<StorageService>().initialize();
      await locator<PushNotificationService>().initialize();
      locator<SocketService>().connect();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: cubits,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        child: BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, state) {
            return MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: state.locale,
              theme: theme,
              onGenerateRoute: onGenerateRoute,
            );
          },
        ),
      ),
    );
  }
}

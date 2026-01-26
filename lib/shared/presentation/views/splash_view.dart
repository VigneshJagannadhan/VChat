import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vignesh_project_01/core/di/locator.dart';
import 'package:vignesh_project_01/core/helpers/navigation_helper.dart';
import 'package:vignesh_project_01/core/services/storage_service.dart';
import 'package:vignesh_project_01/core/services/update_service.dart';
import 'package:vignesh_project_01/core/themes/app_styles.dart';
import 'package:vignesh_project_01/features/auth/presentation/views/auth_view.dart';
import 'package:vignesh_project_01/features/chat/presentation/views/chat_list_view.dart';
import 'package:vignesh_project_01/l10n/app_localizations.dart';
import 'package:vignesh_project_01/shared/presentation/cubits/update/update_cubit.dart';

class SplashView extends StatefulWidget {
  static const String route = '/';
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  void _initAsync() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      StorageService storageService = locator<StorageService>();
      UpdateService updateService = locator<UpdateService>();
      UpdateCubit updateCubit = context.read<UpdateCubit>();

      var version = await updateService.findVersion();
      await storageService.saveVersion(version: version);
      await updateCubit.checkForUpdate();

      /// ADDING A DELAY JUST TO DISPLAY THE SPLASH UI FOR 2 SECONDS
      await Future.delayed(Duration(seconds: 2));

      var token = await storageService.fetchAccessToken();
      if (token != null) {
        if (!mounted) return;
        NavigationHelper.pushReplacementNamed(
          context: context,
          route: ChatListView.route,
        );
      } else {
        if (!mounted) return;
        NavigationHelper.pushReplacementNamed(
          context: context,
          route: AuthView.route,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: .min,
          children: [
            Text(
              AppLocalizations.of(context)!.appName,
              style: AppStyles.ts24W700cBlack,
            ),
            SizedBox(height: 20.h),
            CupertinoActivityIndicator(),
          ],
        ),
      ),
    );
  }
}

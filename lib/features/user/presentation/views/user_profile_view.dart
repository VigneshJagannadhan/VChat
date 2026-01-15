import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vignesh_project_01/core/constants/app_enums.dart';
import 'package:vignesh_project_01/core/helpers/locale_helpers.dart';
import 'package:vignesh_project_01/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:vignesh_project_01/features/user/presentation/cubits/user/user_cubit.dart';
import 'package:vignesh_project_01/features/user/presentation/cubits/user/user_states.dart';
import 'package:vignesh_project_01/l10n/app_localizations.dart';
import 'package:vignesh_project_01/shared/presentation/cubits/locale/locale_cubit.dart';
import 'package:vignesh_project_01/shared/presentation/cubits/locale/locale_states.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/custom_dropdown.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/custom_error_widget.dart';
import 'package:vk_custom_widgets/vk_custom_widgets.dart';

class UserProfileView extends StatefulWidget {
  static const String route = '/user-profile';
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  UserCubit? userCubit;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userCubit = context.read<UserCubit>();
    userCubit!.getUserDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.userProfileTitle),
      ),
      body: BlocBuilder<UserCubit, UserStates>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CupertinoActivityIndicator());
          }

          if (state is UserFailure) {
            return CustomErrorWidget(
              message: state.failure.message,
              onRetry: () => userCubit?.getUserDetail(),
            );
          }
          if (state is UserLoaded) {
            _nameController.text = state.user.name ?? '';
            _emailController.text = state.user.email ?? '';
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                children: [
                  VkTextFormField(
                    controller: _nameController,
                    label: AppLocalizations.of(context)!.nameLabel,
                  ),
                  SizedBox(height: 20.h),
                  VkTextFormField(
                    controller: _emailController,
                    label: AppLocalizations.of(context)!.emailLabel,
                  ),
                  SizedBox(height: 20.h),

                  VkElevatedButton(
                    label: AppLocalizations.of(context)!.saveButtonLabel,
                    onPressed: () {},
                  ),
                  SizedBox(height: 20.h),
                  BlocConsumer<LocaleCubit, LocaleState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      final selectedLocale = SupportedLocalesX.fromLocale(
                        state.locale,
                      );

                      return CustomDropdown<SupportedLocales>(
                        value: selectedLocale,
                        items: SupportedLocales.values,
                        hint: 'Select language',
                        labelBuilder: (item) => item.label,
                        onChanged: (value) {
                          context.read<LocaleCubit>().setLocale(value);
                        },
                      );
                    },
                  ),

                  SizedBox(height: 10.h),
                  VkElevatedButton(
                    backgroundColor: Colors.red,
                    label: AppLocalizations.of(context)!.logoutButtonLabel,
                    onPressed: () {
                      var auth = context.read<AuthCubit>();
                      auth.logout(context);
                    },
                  ),
                ],
              ),
            );
          }

          return CustomErrorWidget(
            message: 'Something went wrong',
            onRetry: () => userCubit?.getUserDetail(),
          );
        },
      ),
    );
  }
}

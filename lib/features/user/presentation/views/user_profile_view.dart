import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vignesh_project_01/core/constants/app_enums.dart';
import 'package:vignesh_project_01/core/helpers/locale_helpers.dart';
import 'package:vignesh_project_01/core/themes/app_dimens.dart';
import 'package:vignesh_project_01/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:vignesh_project_01/features/user/presentation/cubits/user/user_cubit.dart';
import 'package:vignesh_project_01/features/user/presentation/cubits/user/user_states.dart';
import 'package:vignesh_project_01/l10n/app_localizations.dart';
import 'package:vignesh_project_01/shared/presentation/cubits/locale/locale_cubit.dart';
import 'package:vignesh_project_01/shared/presentation/cubits/locale/locale_states.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_app_bar.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_body_column.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_button.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_dropdown_field.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_error_view.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_loader.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_scaffold.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_text_field.dart';

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
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppScaffold(
      appBar: AppAppBar(title: l10n.userProfileTitle),
      body: BlocBuilder<UserCubit, UserStates>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const AppLoader();
          }

          if (state is UserFailure) {
            return AppErrorView(
              message: state.failure.message,
              onRetry: () => userCubit?.getUserDetail(),
            );
          }
          if (state is UserLoaded) {
            _nameController.text = state.user.name ?? '';
            _emailController.text = state.user.email ?? '';
            return SingleChildScrollView(
              child: AppBodyColumn(
                spacing: AppSpacing.xl,
                children: [
                  AppTextField(
                    controller: _nameController,
                    label: l10n.nameLabel,
                  ),
                  AppTextField(
                    controller: _emailController,
                    label: l10n.emailLabel,
                  ),
                  AppButton.primary(
                    label: l10n.saveButtonLabel,
                    onPressed: () {},
                  ),
                  BlocBuilder<LocaleCubit, LocaleState>(
                    builder: (context, state) {
                      return AppDropdownField<SupportedLocales>(
                        value: SupportedLocalesX.fromLocale(state.locale),
                        items: SupportedLocales.values,
                        hint: l10n.selectLanguageHint,
                        labelBuilder: (item) => item.label,
                        onChanged: (value) =>
                            context.read<LocaleCubit>().setLocale(value),
                      );
                    },
                  ),
                  AppButton.destructive(
                    label: l10n.logoutButtonLabel,
                    onPressed: () => context.read<AuthCubit>().logout(context),
                  ),
                ],
              ),
            );
          }

          // UserIntial: the first fetch hasn't started yet.
          return const AppLoader();
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vignesh_project_01/core/constants/app_enums.dart';
import 'package:vignesh_project_01/core/constants/app_validators.dart';
import 'package:vignesh_project_01/core/helpers/locale_helpers.dart';
import 'package:vignesh_project_01/core/themes/app_dimens.dart';
import 'package:vignesh_project_01/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:vignesh_project_01/features/user/domain/entities/user_entity.dart';
import 'package:vignesh_project_01/features/user/presentation/cubits/user/user_cubit.dart';
import 'package:vignesh_project_01/features/user/presentation/cubits/user/user_states.dart';
import 'package:vignesh_project_01/l10n/app_localizations.dart';
import 'package:vignesh_project_01/shared/others/snackbars/general_snackbar.dart';
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
  late final UserCubit _userCubit;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  /// The server value last written into [_nameController]. A newer server
  /// value only replaces the field if the user hasn't edited it since.
  String? _appliedName;

  @override
  void initState() {
    super.initState();
    _userCubit = context.read<UserCubit>();
    _userCubit.getUserDetail();
    // getUserDetail emits the cached profile synchronously, before the
    // listener below subscribes.
    final state = _userCubit.state;
    if (state is UserLoaded) _applyUser(state.user);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _applyUser(UserEntity user) {
    final serverName = user.name ?? '';
    final userHasEdited =
        _appliedName != null && _nameController.text != _appliedName;
    if (!userHasEdited) _nameController.text = serverName;
    _appliedName = serverName;
    _emailController.text = user.email ?? '';
  }

  void _save() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    _userCubit.updateProfile(name: _nameController.text);
  }

  bool _wasSaving = false;

  void _onStateChanged(BuildContext context, UserStates state) {
    if (state is! UserLoaded) return;

    final finishedSaving = _wasSaving && !state.isSaving;
    _wasSaving = state.isSaving;

    if (!finishedSaving) {
      if (!state.isSaving) _applyUser(state.user);
      return;
    }

    final l10n = AppLocalizations.of(context)!;
    final failure = state.saveFailure;
    if (failure == null) {
      // Saved: the field now matches the server, so it isn't "edited".
      _appliedName = null;
      _applyUser(state.user);
      showGeneralSnackbar(
        context: context,
        errorMessage: l10n.profileUpdatedMessage,
        isFailure: false,
      );
    } else {
      showGeneralSnackbar(
        context: context,
        errorMessage: failure.errorCode == '409'
            ? l10n.usernameTakenMessage
            : failure.message,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppScaffold(
      appBar: AppAppBar(title: l10n.userProfileTitle),
      body: BlocConsumer<UserCubit, UserStates>(
        listener: _onStateChanged,
        builder: (context, state) {
          return switch (state) {
            UserIntial() || UserLoading() => const AppLoader(),
            UserFailure(:final failure) => AppErrorView(
              message: failure.message,
              onRetry: _userCubit.getUserDetail,
            ),
            UserLoaded() => _ProfileForm(
              formKey: _formKey,
              state: state,
              nameController: _nameController,
              emailController: _emailController,
              onSave: _save,
            ),
          };
        },
      ),
    );
  }
}

class _ProfileForm extends StatelessWidget {
  const _ProfileForm({
    required this.formKey,
    required this.state,
    required this.nameController,
    required this.emailController,
    required this.onSave,
  });

  final GlobalKey<FormState> formKey;
  final UserLoaded state;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: AppBodyColumn(
          spacing: AppSpacing.xl,
          children: [
            AppTextField(
              controller: nameController,
              label: l10n.nameLabel,
              enabled: !state.isSaving,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.name],
              validator: AppValidators.validateName,
              onFieldSubmitted: (_) => onSave(),
            ),
            // Email is the login identity; the backend doesn't allow changing it.
            AppTextField(
              controller: emailController,
              label: l10n.emailLabel,
              enabled: false,
            ),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: nameController,
              builder: (context, value, _) {
                final hasChanges = value.text.trim() != (state.user.name ?? '');
                return AppButton.primary(
                  label: l10n.saveButtonLabel,
                  isLoading: state.isSaving,
                  onPressed: hasChanges ? onSave : null,
                );
              },
            ),
            BlocBuilder<LocaleCubit, LocaleState>(
              builder: (context, localeState) {
                return AppDropdownField<SupportedLocales>(
                  value: SupportedLocalesX.fromLocale(localeState.locale),
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
      ),
    );
  }
}

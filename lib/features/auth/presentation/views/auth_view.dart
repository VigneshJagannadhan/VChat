import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vignesh_project_01/core/constants/app_validators.dart';
import 'package:vignesh_project_01/core/extensions/theme_extensions.dart';
import 'package:vignesh_project_01/core/themes/app_dimens.dart';
import 'package:vignesh_project_01/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:vignesh_project_01/features/auth/presentation/cubits/auth/auth_states.dart';
import 'package:vignesh_project_01/l10n/app_localizations.dart';
import 'package:vignesh_project_01/shared/others/snackbars/general_snackbar.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_body_column.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_button.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_scaffold.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/app_text_field.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/text/body_text.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/text/headline_text.dart';

class AuthView extends StatefulWidget {
  static const String route = '/auth_view';
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final TextEditingController _nameController = TextEditingController(
    text: 'user',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'alicedoe@gmail.com',
  );
  final TextEditingController _passwordController = TextEditingController(
    text: 'Abcd@1234',
  );
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> _isLogin = ValueNotifier(true);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _isLogin.dispose();
    super.dispose();
  }

  Future<void> _submit(bool isLogin) async {
    if (!_formKey.currentState!.validate()) return;
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final name = _nameController.text.trim();
    final auth = context.read<AuthCubit>();
    isLogin
        ? await auth.login(context: context, email: email, password: password)
        : await auth.register(
            context: context,
            email: email,
            name: name,
            password: password,
          );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppScaffold(
      scrollable: true,
      body: ValueListenableBuilder(
        valueListenable: _isLogin,
        builder: (context, isLogin, _) {
          return Form(
            key: _formKey,
            child: AppBodyColumn(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: AppSpacing.md,
              children: [
                HeadlineText.large(
                  isLogin ? l10n.loginTitle : l10n.registerTitle,
                ),
                const SizedBox(height: AppSpacing.lg),
                if (!isLogin)
                  Center(
                    child: ProfileImageWidget(
                      onSelected: (file) {
                        print('File : ${file?.path}');
                      },
                    ),
                  ),
                if (!isLogin)
                  AppTextField(
                    label: l10n.nameLabel,
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    autofillHints: const [AutofillHints.name],
                    validator: AppValidators.validateName,
                  ),
                AppTextField(
                  label: l10n.emailLabel,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.email],
                  validator: AppValidators.validateEmail,
                ),
                AppTextField.password(
                  label: l10n.passwordLabel,
                  controller: _passwordController,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submit(isLogin),
                  validator: isLogin
                      ? AppValidators.validateLoginPassword
                      : AppValidators.validateRegistrationPassword,
                ),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthFailure) {
                      showGeneralSnackbar(
                        context: context,
                        errorMessage: state.failure.message,
                      );
                    }
                  },
                  builder: (context, state) {
                    return AppButton.primary(
                      isLoading: state is AuthLoading,
                      label: isLogin ? l10n.loginTitle : l10n.registerTitle,
                      onPressed: () => _submit(isLogin),
                    );
                  },
                ),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    AppButton.text(
                      label: isLogin
                          ? l10n.noAccountPrompt
                          : l10n.haveAccountPrompt,
                      onPressed: () {
                        _formKey.currentState?.reset();
                        _isLogin.value = !_isLogin.value;
                      },
                    ),
                    AppButton.text(
                      label: l10n.forgotPasswordLabel,
                      onPressed: () => showGeneralSnackbar(
                        context: context,
                        errorMessage: l10n.featureInProgressMessage,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ProfileImageWidget extends StatefulWidget {
  const ProfileImageWidget({super.key, required this.onSelected});

  final Function(File? file) onSelected;

  @override
  State<ProfileImageWidget> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  final ValueNotifier<File?> _selectedImage = ValueNotifier(null);

  @override
  void dispose() {
    _selectedImage.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    final path = result?.files.single.path;
    if (path == null) return;
    final file = File(path);
    _selectedImage.value = file;
    widget.onSelected(file);
  }

  @override
  Widget build(BuildContext context) {
    final label = AppLocalizations.of(context)!.pickProfileImageLabel;

    return Semantics(
      button: true,
      label: label,
      excludeSemantics: true,
      onTap: _pickImage,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: _pickImage,
        child: ValueListenableBuilder(
          valueListenable: _selectedImage,
          builder: (context, image, child) {
            final colors = context.colors;
            return Stack(
              children: [
                DecoratedBox(
                  decoration: ShapeDecoration(
                    shape: const CircleBorder(),
                    gradient: context.chatColors.sentBubbleGradient,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.xs),
                    child: CircleAvatar(
                      backgroundColor: colors.surfaceContainerHigh,
                      backgroundImage: image != null ? FileImage(image) : null,
                      radius: AppSizes.avatarLg,
                      child: image != null
                          ? null
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.sm,
                              ),
                              child: BodyText.small(
                                label,
                                textAlign: TextAlign.center,
                              ),
                            ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    backgroundColor: colors.primary,
                    radius: AppSpacing.lg,
                    child: Icon(
                      image != null ? Icons.edit : Icons.add_a_photo,
                      size: AppSizes.iconSm,
                      color: colors.onPrimary,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

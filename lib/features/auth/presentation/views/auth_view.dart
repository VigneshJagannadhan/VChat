import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vignesh_project_01/core/constants/app_validators.dart';
import 'package:vignesh_project_01/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:vignesh_project_01/features/auth/presentation/cubits/auth/auth_states.dart';
import 'package:vignesh_project_01/shared/others/snackbars/general_snackbar.dart';
import 'package:vignesh_project_01/shared/presentation/widgets/primary_button.dart';
import 'package:vk_custom_widgets/vk_custom_widgets.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ValueListenableBuilder(
          valueListenable: _isLogin,
          builder: (context, value, _) {
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value ? 'Login' : 'Register',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(height: 30.h),
                  if (!value)
                    VkTextFormField(
                      label: "Name",
                      controller: _nameController,
                      validator: (value) => AppValidators.validateName(value),
                    ),
                  if (!value) SizedBox(height: 10.h),
                  VkTextFormField(
                    label: "Email",
                    controller: _emailController,
                    validator: (value) => AppValidators.validateEmail(value),
                  ),
                  SizedBox(height: 10.h),
                  VkPasswordFormField(
                    label: "Password",
                    controller: _passwordController,
                    validator: (val) => value
                        ? AppValidators.validateLoginPassword(val)
                        : AppValidators.validateRegistrationPassword(val),
                  ),
                  SizedBox(height: 10.h),
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
                      return PrimaryButton(
                        isLoading: state is AuthLoading,
                        label: value ? "Login" : "Register",
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            String email = _emailController.text.trim();
                            String password = _passwordController.text.trim();
                            String name = _nameController.text.trim();
                            AuthCubit auth = context.read<AuthCubit>();
                            value
                                ? await auth.login(
                                    context: context,
                                    email: email,
                                    password: password,
                                  )
                                : await auth.register(
                                    context: context,
                                    email: email,
                                    name: name,
                                    password: password,
                                  );
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          _formKey.currentState?.reset();
                          _isLogin.value = !_isLogin.value;
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text(
                            value
                                ? 'Do not have an account?'
                                : 'Already have an account?',
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: () => showGeneralSnackbar(
                          context: context,
                          errorMessage: 'Feature inprogress!',
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: const Text('Forgot Password?'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:talent_showcase_app/core/core_exports.dart';
import 'package:talent_showcase_app/features/auth/presentation/cubit/auth_cubit.dart';

class LoginPageBody extends StatelessWidget {
  const LoginPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthCubit, AuthState>(
          listener: _handleAuthListener,
          child: SingleChildScrollView(
            padding: AppSizes.paddingXL.toAllEdgeInsets(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 100,
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _Header(),
                  SizedBox(height: 40),
                  _LoginForm(),
                  SizedBox(height: 24),
                  _SubmitButton(),
                  SizedBox(height: 16),
                  _Footer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleAuthListener(BuildContext context, AuthState state) {
    if (state.status.isFailure) {
      showAppAlert(
        context,
        message: state.errorMessage,
        type: FlushbarType.error,
      );
    } else if (state.status.isSuccess) {
      showAppAlert(context, message: AppConstants.loginSuccess);
      getIt<NavigationService>().navigateAndRemoveUntil(
        RouteNames.mainShellPageRoute,
      );
    }
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Hero(
          tag: 'app_logo',
          child: GradientText(
            AppConfig.appName,
            style: Theme.of(
              context,
            ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800),
            gradient: AppGradients.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppConstants.showYourSkillsToTheWorld,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: AppColors.fontGray),
        ),
      ],
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (BuildContext context, AuthState state) {
          return Column(
            children: <Widget>[
              _buildTextField(
                context: context,
                state: state,
                label: AppConstants.email,
                prefixIcon: Icons.email_outlined,
                initialValue: state.email.value,
                isPassword: false,
                validator:
                    (_) =>
                        state.email.isValid
                            ? null
                            : AppConstants.pleaseEnterAValidEmail,
                onChanged:
                    (String value) =>
                        context.read<AuthCubit>().emailChanged(value),
              ),
              const SizedBox(height: 16),
              _buildTextField(
                context: context,
                state: state,
                label: AppConstants.password,
                prefixIcon: Icons.lock_outline,
                initialValue: state.password.value,
                isPassword: true,
                obscureText: !state.isPasswordVisible,
                validator:
                    (_) =>
                        state.password.isValid
                            ? null
                            : AppConstants.passwordMustBe6Characters,
                onChanged:
                    (String value) =>
                        context.read<AuthCubit>().passwordChanged(value),
                onSuffixIconPressed:
                    () => context.read<AuthCubit>().onPasswordVisible(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required AuthState state,
    required String label,
    required IconData prefixIcon,
    required String initialValue,
    required bool isPassword,
    required String? Function(String?) validator,
    required void Function(String) onChanged,
    bool obscureText = false,
    void Function()? onSuffixIconPressed,
  }) {
    return AppTextField(
      initialValue: initialValue,
      label: label,
      prefixIcon: prefixIcon,
      keyboardType:
          isPassword
              ? TextInputType.visiblePassword
              : TextInputType.emailAddress,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      suffixIcon:
          isPassword
              ? IconButton(
                icon: Icon(
                  state.isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: onSuffixIconPressed,
              )
              : null,
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (BuildContext context, AuthState state) {
        return CustomFilledButton(
          onPressed: () => context.read<AuthCubit>().loginSubmitted(),
          label: AppConstants.signIn,
          isLoading: state.status.isInProgress,
        );
      },
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Text(
          AppConstants.newHere,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        TextButton(
          onPressed: () {
            showAppAlert(
              context,
              message: AppConstants.createAccountMessage,
              type: FlushbarType.info,
            );
          },
          child: const Text(AppConstants.createAccount),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:talent_showcase_app/core/core_exports.dart'
    show
        AppColors,
        AppConfig,
        AppConstants,
        AppGradients,
        AppTextField,
        GradientText,
        Validators;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 100,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildHeader(),
                const SizedBox(height: 40),
                _buildLoginForm(),
                const SizedBox(height: 24),
                _buildLoginButton(),
                const SizedBox(height: 16),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
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

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: <Widget>[
          AppTextField(
            controller: _emailController,
            label: AppConstants.email,
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: Validators.email,
            onChanged: _onFormChanged,
          ),
          const SizedBox(height: 16),
          AppTextField(
            controller: _passwordController,
            label: AppConstants.password,
            prefixIcon: Icons.lock_outline,
            obscureText: true,
            textInputAction: TextInputAction.done,
            validator: Validators.required,
            onChanged: _onFormChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: FilledButton(
        onPressed: _submitForm,
        // onPressed: state.isLoading ? null : _submitForm,
        child:
            _isLoading
                ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
                : const Text(AppConstants.signIn),
      ),
    );
  }

  Widget _buildFooter() {
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
        TextButton(onPressed: () {}, child: const Text('Create Account')),
      ],
    );
  }

  void _onFormChanged(String _) {
    // context.read<AuthBloc>().add(AuthFormChanged(
    //       email: _emailController.text,
    //       password: _passwordController.text,
    //     ));
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // context.read<AuthBloc>().add(AuthLoginRequested(
      //       email: _emailController.text,
      //       password: _passwordController.text,
      //     ));
    }
  }

  // void _handleAuthState(BuildContext context, AuthState state) {
  //   state.whenOrNull(
  //     failure: (message) => AppSnackbar.showError(context, message),
  //   );
  // }
}

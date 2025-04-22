import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_showcase_app/core/core_exports.dart' show getIt;

import 'package:talent_showcase_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:talent_showcase_app/features/auth/presentation/widgets/login_page_body.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>(),
      child: const LoginPageBody(),
    );
  }
}

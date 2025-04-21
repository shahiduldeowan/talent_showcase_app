import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_showcase_app/core/core_exports.dart'
    show AssetPaths, NavigationService, RouteNames, ThemeExtension, getIt;
import 'package:talent_showcase_app/features/splash/presentation/cubit/splash_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double scaleFactor = 0.2;

  @override
  void initState() {
    super.initState();

    // ignore: always_specify_types
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        scaleFactor = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create:
          (BuildContext splashCubit) => getIt<SplashCubit>()..checkAuthStatus(),
      child: _createSplashPage(),
    );
  }

  Widget _createSplashPage() {
    return BlocListener<SplashCubit, SplashState>(
      listener: (BuildContext context, SplashState state) {
        if (state is SplashStateUnauthenticated) {
          getIt<NavigationService>().navigateAndRemoveUntil(
            RouteNames.loginPageRoute,
          );
        } else if (state is SplashStateAuthenticated) {
          getIt<NavigationService>().navigateAndRemoveUntil(
            RouteNames.homePageRoute,
          );
        } else if (state is SplashStateError) {}
      },
      child: Scaffold(
        backgroundColor: context.primaryColor,
        body: SizedBox(
          width: double.maxFinite,
          child: Center(
            child: AnimatedScale(
              scale: scaleFactor,
              duration: const Duration(milliseconds: 3080),
              curve: Curves.linear,
              child: Image.asset(
                AssetPaths.logo,
                width: 300,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

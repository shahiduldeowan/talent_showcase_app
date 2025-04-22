import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_showcase_app/core/core_exports.dart'
    show
        AssetPaths,
        FlushbarType,
        NavigationService,
        ResponsiveExtension,
        RouteNames,
        ThemeExtension,
        getIt,
        showAppAlert;
import 'package:talent_showcase_app/features/splash/presentation/cubit/splash_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  static const double _initialScaleFactor = 0.2;
  static const double _finalScaleFactor = 1.0;
  static const Duration _animationDuration = Duration(milliseconds: 3080);
  static const Duration _initialDelay = Duration(milliseconds: 100);

  double scaleFactor = _initialScaleFactor;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    Future<dynamic>.delayed(_initialDelay, () {
      setState(() {
        scaleFactor = _finalScaleFactor;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (_) => getIt<SplashCubit>()..checkAuthStatus(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: _handleStateChanges,
        child: _buildScaffold(context),
      ),
    );
  }

  void _handleStateChanges(BuildContext context, SplashState state) {
    if (state is SplashStateUnauthenticated) {
      getIt<NavigationService>().navigateAndRemoveUntil(
        RouteNames.loginPageRoute,
      );
    } else if (state is SplashStateAuthenticated) {
      getIt<NavigationService>().navigateAndRemoveUntil(
        RouteNames.mainShellRoute,
      );
    } else if (state is SplashStateError) {
      showAppAlert(context, message: state.message, type: FlushbarType.error);
    }
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: context.primaryColor,
      body: SizedBox(
        width: double.infinity,
        child: Center(child: _buildAnimatedLogo()),
      ),
    );
  }

  Widget _buildAnimatedLogo() {
    return AnimatedScale(
      scale: scaleFactor,
      duration: _animationDuration,
      curve: Curves.linear,
      child: Image.asset(AssetPaths.logo, width: 300.w, fit: BoxFit.cover),
    );
  }
}

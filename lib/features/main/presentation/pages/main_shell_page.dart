import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_showcase_app/core/core_exports.dart'
    show NavigationService, RouteNames, appExitDialog, getIt;
import 'package:talent_showcase_app/features/feed/presentation/pages/feed_page.dart';
import 'package:talent_showcase_app/features/main/presentation/cubit/main_cubit.dart';
import 'package:talent_showcase_app/features/main/presentation/widgets/main_bottom_nav_bar_widget.dart';
import 'package:talent_showcase_app/features/main/presentation/widgets/main_shell_app_bar.dart';
import 'package:talent_showcase_app/features/profile/presentaion/pages/profile_page.dart';

class MainShellPage extends StatelessWidget {
  const MainShellPage({super.key});

  static final PageStorageBucket _pageStorageBucket = PageStorageBucket();
  List<Widget> get _screens => const <Widget>[FeedScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainCubit>(
      create: (_) => getIt<MainCubit>(),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult:
            (bool didPop, dynamic result) => appExitDialog(context),
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: const MainShellAppBar(),
            body: PageStorage(
              bucket: _pageStorageBucket,
              child: BlocBuilder<MainCubit, MainState>(
                builder: (BuildContext context, MainState state) {
                  return IndexedStack(
                    index: state.currentIndex,
                    children: _screens,
                  );
                },
              ),
            ),
            bottomNavigationBar: const MainBottomNavBarWidget(),
            floatingActionButton: BlocBuilder<MainCubit, MainState>(
              builder: (BuildContext context, MainState state) {
                if (state.currentIndex == 0) {
                  return FloatingActionButton(
                    onPressed: () => _navigateToCreatePost(),
                    child: const Icon(Icons.add, size: 28),
                  );
                }
                return const SizedBox();
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          ),
        ),
      ),
    );
  }

  void _navigateToCreatePost() {
    getIt<NavigationService>().navigateTo(RouteNames.createPostPageRoute);
  }
}

class _KeepAliveTabPage extends StatefulWidget {
  final Widget content;
  const _KeepAliveTabPage({required this.content});

  @override
  State<_KeepAliveTabPage> createState() => _KeepAliveTabPageState();
}

class _KeepAliveTabPageState extends State<_KeepAliveTabPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.content;
  }
}

/*


class MainShellPage extends StatelessWidget {
  const MainShellPage({super.key});

  static final PageStorageBucket _pageStorageBucket = PageStorageBucket();
  List<Widget> get _screens => const <Widget>[FeedScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainCubit>(
      create: (_) => getIt<MainCubit>(),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult:
            (bool didPop, dynamic result) => appExitDialog(context),
        child: Scaffold(
          appBar: const MainShellAppBar(),
          body: PageStorage(
            bucket: _pageStorageBucket,
            child: BlocBuilder<MainCubit, MainState>(
              builder: (BuildContext context, MainState state) {
                return IndexedStack(
                  index: state.currentIndex,
                  children: _screens,
                );
              },
            ),
          ),
          bottomNavigationBar: const MainBottomNavBarWidget(),
          floatingActionButton: BlocBuilder<MainCubit, MainState>(
            builder: (BuildContext context, MainState state) {
              if (state.currentIndex == 0) {
                return FloatingActionButton(
                  onPressed: () => _navigateToCreatePost(),
                  child: const Icon(Icons.add, size: 28),
                );
              }
              return const SizedBox();
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }

  void _navigateToCreatePost() {
    getIt<NavigationService>().navigateTo(RouteNames.createPostPageRoute);
  }
}


*/

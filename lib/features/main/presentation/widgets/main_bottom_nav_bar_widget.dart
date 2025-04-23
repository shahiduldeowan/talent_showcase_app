import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_showcase_app/core/core_exports.dart' show AppConstants;
import 'package:talent_showcase_app/features/main/presentation/cubit/main_cubit.dart';

class MainBottomNavBarWidget extends StatelessWidget {
  const MainBottomNavBarWidget({super.key});

  List<NavItemModel> get _navItems => <NavItemModel>[
    NavItemModel(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: AppConstants.home,
    ),
    NavItemModel(
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      label: AppConstants.profile,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (BuildContext context, MainState state) {
        return BottomNavigationBar(
          currentIndex: state.currentIndex,
          onTap: (int index) {
            context.read<MainCubit>().selecteItem(index);
          },
          showSelectedLabels: true,
          showUnselectedLabels: false,
          items:
              _navItems.map((NavItemModel navItem) {
                return BottomNavigationBarItem(
                  icon: Icon(navItem.icon),
                  activeIcon: Icon(navItem.activeIcon),
                  label: navItem.label,
                );
              }).toList(),
        );
      },
    );
  }
}

class NavItemModel {
  NavItemModel({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
}

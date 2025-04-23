import 'package:flutter/material.dart';
import 'package:talent_showcase_app/core/core_exports.dart'
    show AppSizeFormatExtension, AppSizes, DateFormatter;

class MainShellAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainShellAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: Padding(
        padding: AppSizes.paddingXL.toLeftEdgeInsets(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Good morning Deowan',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              DateFormatter.defaultDateFormat(),
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),

      // actions: _buildAppBarActions(),
    );
  }

  // List<Widget> _buildAppBarActions() {
  //   if (_currentIndex == 1) {
  //     return <Widget>[
  //       IconButton(
  //         icon: const Icon(Icons.settings, color: Colors.white),
  //         onPressed: () {},
  //       ),
  //       IconButton(
  //         icon: const Icon(Icons.logout, color: Colors.white),
  //         onPressed: () {
  //           // Navigator.pushReplacementNamed(context, '/login');
  //         },
  //       ),
  //     ];
  //   }
  //   // Default AppBar actions for Feed Screen
  //   return <Widget>[];
  // }

  @override
  Size get preferredSize => const Size.fromHeight(68);
}

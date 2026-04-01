import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/blocs/theme_bloc/theme_cubit.dart';
import 'package:pizza_app/screens/home/components/cart_badge.dart';

/// Custom AppBar for HomeScreen
/// Dipisah untuk cleaner code
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double screenWidth;
  final VoidCallback onCartTap;
  final VoidCallback onSignOut;

  const HomeAppBar({
    super.key,
    required this.screenWidth,
    required this.onCartTap,
    required this.onSignOut,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Row(
        children: [
          Image.asset('assets/8.png', scale: screenWidth * 0.035),
          SizedBox(width: screenWidth * 0.012),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pizzify',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: screenWidth * 0.055,
                ),
              ),
              Text(
                'Delivery your favorite pizza',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: screenWidth * 0.025,
                ),
              ),
            ],
          )
        ],
      ),
      actions: [
        CartBadgeWidget(onTap: onCartTap),
        PopupMenuButton<String>(
          icon: const Icon(Icons.menu_rounded),
          onSelected: (value) {
            switch (value) {
              case 'theme':
                context.read<ThemeCubit>().toggleTheme();
                break;
              case 'sign_out':
                onSignOut();
                break;
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'theme',
              child: Row(
                children: [
                  Icon(Icons.brightness_6),
                  SizedBox(width: 12),
                  Text('Toggle Theme'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'sign_out',
              child: Row(
                children: [
                  Icon(CupertinoIcons.arrow_right_to_line, color: Colors.red),
                  SizedBox(width: 12),
                  Text('Sign Out', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

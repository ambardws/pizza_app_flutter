import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:pizza_app/blocs/authentication_bloc/authentication_bloc.dart';
  import 'package:pizza_app/blocs/theme_bloc/theme_cubit.dart';
import 'package:pizza_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
  import 'package:pizza_app/screens/profile/components/profile_menu_item.dart';

  /// Profile screen - menampilkan user info dan settings
  /// Termasuk: info akun, theme toggle, sign out
  class ProfileScreen extends StatelessWidget {
    const ProfileScreen({super.key});

    @override
    Widget build(BuildContext context) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;

      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.02),

                // Header
                Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: screenWidth * 0.07,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),

                // User Info Card
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      final userName = state.status == AuthenticationStatus.authenticated
                          ? state.user?.name ?? 'Guest'
                          : 'Guest';
                      final userEmail = state.status == AuthenticationStatus.authenticated
                          ? state.user?.email ?? 'guest@example.com'
                          : 'guest@example.com';

                      return Row(
                        children: [
                          Container(
                            width: screenWidth * 0.15,
                            height: screenWidth * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              CupertinoIcons.person_fill,
                              size: screenWidth * 0.08,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.04),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userName,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.045,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.005),
                                Text(
                                  userEmail,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: screenWidth * 0.03,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                SizedBox(height: screenHeight * 0.03),

                // Menu Section - Account
                Text(
                  'Account',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                  ),
                ),
                SizedBox(height: screenHeight * 0.015),

                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      ProfileMenuItems(
                        icon: CupertinoIcons.location_solid,
                        title: 'Delivery Address',
                        subtitle: 'Manage your addresses',
                        onTap: () {
                          // TODO: Navigate to address management
                        },
                      ),
                      Divider(height: 1, indent: screenWidth * 0.15),
                      ProfileMenuItems(
                        icon: CupertinoIcons.creditcard,
                        title: 'Payment Methods',
                        subtitle: 'Manage payment options',
                        onTap: () {
                          // TODO: Navigate to payment methods
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.03),

                // Menu Section - Preferences
                Text(
                  'Preferences',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                  ),
                ),
                SizedBox(height: screenHeight * 0.015),

                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: BlocBuilder<ThemeCubit, ThemeMode>(
                    builder: (context, themeMode) {
                      return Column(
                        children: [
                          ProfileMenuItems(
                            icon: CupertinoIcons.moon_fill,
                            title: 'Dark Mode',
                            subtitle: themeMode == ThemeMode.dark
                                ? 'Currently enabled'
                                : 'Currently disabled',
                            trailing: Switch(
                              value: themeMode == ThemeMode.dark,
                              onChanged: (value) {
                                context.read<ThemeCubit>().toggleTheme();
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                SizedBox(height: screenHeight * 0.03),

                // Menu Section - Other
                Text(
                  'Other',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                  ),
                ),
                SizedBox(height: screenHeight * 0.015),

                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      ProfileMenuItems(
                        icon: CupertinoIcons.info_circle_fill,
                        title: 'About',
                        subtitle: 'App version 1.0.0',
                        onTap: () {
                          // TODO: Show about dialog
                        },
                      ),
                      Divider(height: 1, indent: screenWidth * 0.15),
                      ProfileMenuItems(
                        icon: CupertinoIcons.question_circle_fill,
                        title: 'Help & Support',
                        subtitle: 'Get help with your orders',
                        onTap: () {
                          // TODO: Navigate to help
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.04),

                // Sign Out Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _showSignOutDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(CupertinoIcons.arrow_right_to_line),
                        SizedBox(width: screenWidth * 0.02),
                        Text(
                          'Sign Out',
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.04),
              ],
            ),
          ),
        ),
      );
    }

    void _showSignOutDialog(BuildContext context) {
      final screenWidth = MediaQuery.of(context).size.width;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Sign Out',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.05,
            ),
          ),
          content: Text(
            'Are you sure you want to sign out?',
            style: TextStyle(fontSize: screenWidth * 0.035),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: screenWidth * 0.035,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                
                context.read<SignInBloc>().add(SignOutRequired());
              },
              child: Text(
                'Sign Out',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
import 'package:clinic/core/services/get_it_service.dart';
import 'package:flutter/material.dart';
import 'package:clinic/core/utils/app_colors.dart';
import 'package:clinic/core/widgets/custom_button.dart';
import 'package:clinic/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:clinic/features/auth/presentation/views/signin_view.dart';
import 'package:clinic/features/admin/presentation/views/admin_setup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user_entity.dart';
import '../bloc/profile_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    return BlocProvider(
      create: (context) => getIt<ProfileBloc>()..add(LoadUserProfile(uid!)),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          Widget? userSection;
          if (state is ProfileLoading) {
            userSection = const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            final UserEntity userData = state.user;
            userSection = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header
                Center(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.primaryColor,
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        userData.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        userData.email,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // Personal Information Section
                const Text(
                  'Personal Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildInfoItem(Icons.phone, 'Phone', userData.phone),
                _buildInfoItem(Icons.cake, 'Date of Birth',
                    userData.dateOfBirth.toLocal().toString().split(' ')[0]),
                _buildInfoItem(Icons.location_on, 'Address', userData.address),
                const SizedBox(height: 32),
              ],
            );
          } else {
            userSection = null;
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('My Profile'),
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (userSection != null) userSection,
                  if (state is ProfileError)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Center(
                        child: Text(
                          'Error: \${state.message}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  // Settings Section
                  const Text(
                    'Settings',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildSettingItem(
                    context,
                    Icons.edit,
                    'Edit Profile',
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Edit Profile feature coming soon')),
                      );
                    },
                  ),
                  _buildSettingItem(
                    context,
                    Icons.history,
                    'Appointment History',
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Appointment History feature coming soon')),
                      );
                    },
                  ),
                  _buildSettingItem(
                    context,
                    Icons.notifications,
                    'Notifications',
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Notifications settings feature coming soon')),
                      );
                    },
                  ),
                  _buildSettingItem(
                    context,
                    Icons.language,
                    'Language',
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Language settings feature coming soon')),
                      );
                    },
                  ),
                  _buildSettingItem(
                    context,
                    Icons.help,
                    'Help & Support',
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Help & Support feature coming soon')),
                      );
                    },
                  ),
                  _buildSettingItem(
                    context,
                    Icons.admin_panel_settings,
                    'Admin Setup (Dev)',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminSetupView(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                  // Logout Button
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                      ),
                      onPressed: () async {
                        // Find the SigninCubit and call logout
                        final signinCubit = BlocProvider.of<SigninCubit>(
                            context,
                            listen: false);
                        await signinCubit.logout();
                        // Navigate to login or splash screen after logout
                        Navigator.of(context, rootNavigator: true)
                            .pushNamedAndRemoveUntil(
                                SigninView.routeName, (route) => false);
                      },
                      child: const Text('Logout'),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryColor),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primaryColor),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

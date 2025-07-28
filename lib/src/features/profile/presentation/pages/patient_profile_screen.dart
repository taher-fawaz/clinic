import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/res/app_res.dart';
import '../../../../core/blocs/translate/translate_bloc.dart';
import '../../data/models/patient_model.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_menu_item.dart';
import '../widgets/language_selector.dart';
import '../pages/edit_address_screen.dart';
import '../pages/edit_password_screen.dart';
import '../pages/terms_privacy_screen.dart';

class PatientProfileScreen extends StatefulWidget {
  const PatientProfileScreen({super.key});

  @override
  State<PatientProfileScreen> createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  // Mock patient data - in real app this would come from a repository/bloc
  final PatientModel _mockPatient = PatientModel(
    id: '1',
    name: 'Ahmed Mohamed',
    email: 'ahmed.mohamed@email.com',
    phoneNumber: '+201234567890',
    profileImageUrl: null,
    dateOfBirth: DateTime(1990, 5, 15),
    gender: 'Male',
    address: const PatientAddress(
      street: '123 Main Street',
      city: 'Cairo',
      state: 'Cairo Governorate',
      zipCode: '11511',
      country: 'Egypt',
    ),
    createdAt: DateTime.now().subtract(const Duration(days: 365)),
    updatedAt: DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundPrimary,
      appBar: AppBar(
        title: Text(
          'profile.title'.tr(),
          style: TextStyleManager.getSemiBoldStyle(
            fontSize: FontSize.s18,
            color: ColorManager.onPrimary,
          ),
        ),
        backgroundColor: ColorManager.primary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: ColorManager.onPrimary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppPadding.p16.w),
        child: Column(
          children: [
            // Profile Header
            ProfileHeader(patient: _mockPatient),

            SizedBox(height: AppSize.s24.h),

            // Personal Information Section
            _buildSectionCard(
              title: 'profile.personalInfo.title'.tr(),
              children: [
                ProfileMenuItem(
                  icon: Icons.person_outline,
                  title: 'profile.personalInfo.name'.tr(),
                  subtitle: _mockPatient.name,
                  onTap: () => _showEditNameDialog(),
                ),
                const Divider(height: 1),
                ProfileMenuItem(
                  icon: Icons.phone_outlined,
                  title: 'profile.personalInfo.phone'.tr(),
                  subtitle: _mockPatient.formattedPhoneNumber,
                  onTap: () => _showEditPhoneDialog(),
                ),
                const Divider(height: 1),
                ProfileMenuItem(
                  icon: Icons.email_outlined,
                  title: 'profile.personalInfo.email'.tr(),
                  subtitle: _mockPatient.email,
                  onTap: () => _showEditEmailDialog(),
                ),
              ],
            ),

            SizedBox(height: AppSize.s16.h),

            // Settings Section
            _buildSectionCard(
              title: 'profile.settings.title'.tr(),
              children: [
                ProfileMenuItem(
                  icon: Icons.language_outlined,
                  title: 'profile.settings.language'.tr(),
                  subtitle:
                      context.read<TranslateBloc>().state.languageCode == 'ar'
                          ? 'العربية'
                          : 'English',
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () => _showLanguageSelector(),
                ),
                const Divider(height: 1),
                ProfileMenuItem(
                  icon: Icons.location_on_outlined,
                  title: 'profile.settings.address'.tr(),
                  subtitle: _mockPatient.address?.fullAddress ??
                      'profile.settings.addAddress'.tr(),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () => _navigateToEditAddress(),
                ),
                const Divider(height: 1),
                ProfileMenuItem(
                  icon: Icons.notifications_outlined,
                  title: 'profile.settings.notifications'.tr(),
                  subtitle: 'profile.settings.manageNotifications'.tr(),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () => _showNotificationSettings(),
                ),
              ],
            ),

            SizedBox(height: AppSize.s16.h),

            // Security Section
            _buildSectionCard(
              title: 'profile.security.title'.tr(),
              children: [
                ProfileMenuItem(
                  icon: Icons.lock_outline,
                  title: 'profile.security.changePassword'.tr(),
                  subtitle: 'profile.security.updatePassword'.tr(),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () => _navigateToEditPassword(),
                ),
              ],
            ),

            SizedBox(height: AppSize.s16.h),

            // Legal Section
            _buildSectionCard(
              title: 'profile.legal.title'.tr(),
              children: [
                ProfileMenuItem(
                  icon: Icons.description_outlined,
                  title: 'profile.legal.terms.title'.tr(),
                  subtitle: 'profile.legal.termsSubtitle'.tr(),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () => _navigateToTermsPrivacy('terms'),
                ),
                const Divider(height: 1),
                ProfileMenuItem(
                  icon: Icons.privacy_tip_outlined,
                  title: 'profile.legal.privacy.title'.tr(),
                  subtitle: 'profile.legal.privacySubtitle'.tr(),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () => _navigateToTermsPrivacy('privacy'),
                ),
              ],
            ),

            SizedBox(height: AppSize.s24.h),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _showLogoutDialog(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.error,
                  foregroundColor: ColorManager.onError,
                  padding: EdgeInsets.symmetric(vertical: AppPadding.p16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s12.r),
                  ),
                ),
                child: Text(
                  'profile.logout'.tr(),
                  style: TextStyleManager.getSemiBoldStyle(
                    fontSize: FontSize.s16,
                    color: ColorManager.onError,
                  ),
                ),
              ),
            ),

            SizedBox(height: AppSize.s24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(AppPadding.p16.w),
            child: Text(
              title,
              style: TextStyleManager.getSemiBoldStyle(
                fontSize: FontSize.s16,
                color: ColorManager.textPrimary,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  void _showEditNameDialog() {
    // Implementation for editing name
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('profile.editName.comingSoon'.tr())),
    );
  }

  void _showEditPhoneDialog() {
    // Implementation for editing phone
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('profile.editPhone.comingSoon'.tr())),
    );
  }

  void _showEditEmailDialog() {
    // Implementation for editing email
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('profile.editEmail.comingSoon'.tr())),
    );
  }

  void _showLanguageSelector() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSize.s20.r),
        ),
      ),
      builder: (context) => const LanguageSelector(),
    );
  }

  void _navigateToEditAddress() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            EditAddressScreen(initialAddress: _mockPatient.address),
      ),
    );
  }

  void _showNotificationSettings() {
    // Implementation for notification settings
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('profile.notifications.comingSoon'.tr())),
    );
  }

  void _navigateToEditPassword() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const EditPasswordScreen(),
      ),
    );
  }

  void _navigateToTermsPrivacy(String type) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TermsPrivacyScreen(
          showTerms: type == 'terms',
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('profile.logout.confirm'.tr()),
        content: Text('profile.logout.message'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('common.cancel'.tr()),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Implement logout logic
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('profile.logout.success'.tr())),
              );
            },
            child: Text(
              'profile.logout'.tr(),
              style: TextStyle(color: ColorManager.error),
            ),
          ),
        ],
      ),
    );
  }
}

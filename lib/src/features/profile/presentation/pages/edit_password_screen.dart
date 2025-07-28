import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/res/app_res.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({super.key});

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: ColorManager.backgroundPrimary,
        elevation: 0,
        title: Text(
          'profile.security.changePassword'.tr(),
          style: TextStyleManager.getBoldStyle(
            fontSize: FontSize.s18,
            color: ColorManager.textPrimary,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: ColorManager.textPrimary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppPadding.p20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(AppPadding.p16.w),
                decoration: BoxDecoration(
                  color: ColorManager.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppSize.s12.r),
                  border: Border.all(
                    color: ColorManager.primary.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.security,
                      color: ColorManager.primary,
                      size: AppSize.s24.w,
                    ),
                    SizedBox(width: AppSize.s12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'profile.security.passwordSecurity'.tr(),
                            style: TextStyleManager.getSemiBoldStyle(
                              fontSize: FontSize.s14,
                              color: ColorManager.primary,
                            ),
                          ),
                          SizedBox(height: AppSize.s4.h),
                          Text(
                            'profile.security.passwordDescription'.tr(),
                            style: TextStyleManager.getRegularStyle(
                              fontSize: FontSize.s12,
                              color: ColorManager.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: AppSize.s24.h),

              // Current Password
              _buildPasswordField(
                controller: _currentPasswordController,
                label: 'profile.security.currentPassword'.tr(),
                hint: 'profile.security.enterCurrentPassword'.tr(),
                obscureText: _obscureCurrentPassword,
                onToggleVisibility: () {
                  setState(() {
                    _obscureCurrentPassword = !_obscureCurrentPassword;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'profile.security.currentPasswordRequired'.tr();
                  }
                  return null;
                },
              ),

              SizedBox(height: AppSize.s20.h),

              // New Password
              _buildPasswordField(
                controller: _newPasswordController,
                label: 'profile.security.newPassword'.tr(),
                hint: 'profile.security.enterNewPassword'.tr(),
                obscureText: _obscureNewPassword,
                onToggleVisibility: () {
                  setState(() {
                    _obscureNewPassword = !_obscureNewPassword;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'profile.security.newPasswordRequired'.tr();
                  }
                  if (value.length < 8) {
                    return 'profile.security.passwordTooShort'.tr();
                  }
                  if (!_isPasswordStrong(value)) {
                    return 'profile.security.passwordWeak'.tr();
                  }
                  return null;
                },
              ),

              SizedBox(height: AppSize.s8.h),

              // Password Requirements
              _buildPasswordRequirements(),

              SizedBox(height: AppSize.s20.h),

              // Confirm Password
              _buildPasswordField(
                controller: _confirmPasswordController,
                label: 'profile.security.confirmPassword'.tr(),
                hint: 'profile.security.confirmNewPassword'.tr(),
                obscureText: _obscureConfirmPassword,
                onToggleVisibility: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'profile.security.confirmPasswordRequired'.tr();
                  }
                  if (value != _newPasswordController.text) {
                    return 'profile.security.passwordsDoNotMatch'.tr();
                  }
                  return null;
                },
              ),

              SizedBox(height: AppSize.s32.h),

              // Update Password Button
              SizedBox(
                width: double.infinity,
                height: AppSize.s48.h,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _updatePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary,
                    foregroundColor: ColorManager.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s12.r),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? SizedBox(
                          width: AppSize.s20.w,
                          height: AppSize.s20.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              ColorManager.onPrimary,
                            ),
                          ),
                        )
                      : Text(
                          'profile.security.updatePassword'.tr(),
                          style: TextStyleManager.getSemiBoldStyle(
                            fontSize: FontSize.s16,
                            color: ColorManager.onPrimary,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyleManager.getSemiBoldStyle(
            fontSize: FontSize.s14,
            color: ColorManager.textPrimary,
          ),
        ),
        SizedBox(height: AppSize.s8.h),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          style: TextStyleManager.getRegularStyle(
            fontSize: FontSize.s14,
            color: ColorManager.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyleManager.getRegularStyle(
              fontSize: FontSize.s14,
              color: ColorManager.textSecondary,
            ),
            prefixIcon: Icon(
              Icons.lock_outline,
              color: ColorManager.textSecondary,
              size: AppSize.s20.w,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: ColorManager.textSecondary,
                size: AppSize.s20.w,
              ),
              onPressed: onToggleVisibility,
            ),
            filled: true,
            fillColor: ColorManager.backgroundSecondary,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSize.s12.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSize.s12.r),
              borderSide: BorderSide(
                color: ColorManager.textSecondary.withOpacity(0.2),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSize.s12.r),
              borderSide: BorderSide(
                color: ColorManager.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSize.s12.r),
              borderSide: BorderSide(
                color: ColorManager.error,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSize.s12.r),
              borderSide: BorderSide(
                color: ColorManager.error,
                width: 2,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppPadding.p16.w,
              vertical: AppPadding.p12.h,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordRequirements() {
    final password = _newPasswordController.text;

    return Container(
      padding: EdgeInsets.all(AppPadding.p12.w),
      decoration: BoxDecoration(
        color: ColorManager.backgroundSecondary,
        borderRadius: BorderRadius.circular(AppSize.s8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'profile.security.passwordRequirements'.tr(),
            style: TextStyleManager.getSemiBoldStyle(
              fontSize: FontSize.s12,
              color: ColorManager.textSecondary,
            ),
          ),
          SizedBox(height: AppSize.s8.h),
          _buildRequirementItem(
            'profile.security.minLength'.tr(),
            password.length >= 8,
          ),
          _buildRequirementItem(
            'profile.security.hasUppercase'.tr(),
            password.contains(RegExp(r'[A-Z]')),
          ),
          _buildRequirementItem(
            'profile.security.hasLowercase'.tr(),
            password.contains(RegExp(r'[a-z]')),
          ),
          _buildRequirementItem(
            'profile.security.hasNumber'.tr(),
            password.contains(RegExp(r'[0-9]')),
          ),
          _buildRequirementItem(
            'profile.security.hasSpecialChar'.tr(),
            password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementItem(String text, bool isMet) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppPadding.p2.h),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isMet ? ColorManager.success : ColorManager.textSecondary,
            size: AppSize.s16.w,
          ),
          SizedBox(width: AppSize.s8.w),
          Text(
            text,
            style: TextStyleManager.getRegularStyle(
              fontSize: FontSize.s12,
              color: isMet ? ColorManager.success : ColorManager.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  bool _isPasswordStrong(String password) {
    return password.length >= 8 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[0-9]')) &&
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  void _updatePassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        Navigator.of(context).pop();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('profile.security.passwordUpdated'.tr()),
            backgroundColor: ColorManager.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('profile.security.passwordUpdateError'.tr()),
            backgroundColor: ColorManager.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}

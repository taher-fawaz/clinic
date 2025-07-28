import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/res/app_res.dart';
import '../../data/models/patient_model.dart';

class EditAddressScreen extends StatefulWidget {
  final PatientAddress? initialAddress;

  const EditAddressScreen({
    super.key,
    this.initialAddress,
  });

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _countryController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeFields();
  }

  void _initializeFields() {
    if (widget.initialAddress != null) {
      _streetController.text = widget.initialAddress!.street;
      _cityController.text = widget.initialAddress!.city;
      _stateController.text = widget.initialAddress!.state;
      _postalCodeController.text = widget.initialAddress!.zipCode;
      _countryController.text = widget.initialAddress!.country;
    }
  }

  @override
  void dispose() {
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postalCodeController.dispose();
    _countryController.dispose();
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
          'profile.address.editTitle'.tr(),
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
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveAddress,
            child: Text(
              'common.save'.tr(),
              style: TextStyleManager.getSemiBoldStyle(
                fontSize: FontSize.s14,
                color: _isLoading
                    ? ColorManager.textSecondary
                    : ColorManager.primary,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppPadding.p20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'profile.address.description'.tr(),
                style: TextStyleManager.getRegularStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.textSecondary,
                ),
              ),

              SizedBox(height: AppSize.s24.h),

              // Street Address
              _buildTextField(
                controller: _streetController,
                label: 'profile.address.street'.tr(),
                hint: 'profile.address.streetHint'.tr(),
                icon: Icons.home,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'profile.address.streetRequired'.tr();
                  }
                  return null;
                },
              ),

              SizedBox(height: AppSize.s16.h),

              // City and State Row
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildTextField(
                      controller: _cityController,
                      label: 'profile.address.city'.tr(),
                      hint: 'profile.address.cityHint'.tr(),
                      icon: Icons.location_city,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'profile.address.cityRequired'.tr();
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: AppSize.s12.w),
                  Expanded(
                    child: _buildTextField(
                      controller: _stateController,
                      label: 'profile.address.state'.tr(),
                      hint: 'profile.address.stateHint'.tr(),
                      icon: Icons.map,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'profile.address.stateRequired'.tr();
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppSize.s16.h),

              // Postal Code and Country Row
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _postalCodeController,
                      label: 'profile.address.postalCode'.tr(),
                      hint: 'profile.address.postalCodeHint'.tr(),
                      icon: Icons.local_post_office,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'profile.address.postalCodeRequired'.tr();
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: AppSize.s12.w),
                  Expanded(
                    flex: 2,
                    child: _buildTextField(
                      controller: _countryController,
                      label: 'profile.address.country'.tr(),
                      hint: 'profile.address.countryHint'.tr(),
                      icon: Icons.public,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'profile.address.countryRequired'.tr();
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppSize.s32.h),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: AppSize.s48.h,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveAddress,
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
                          'profile.address.saveAddress'.tr(),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
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
          keyboardType: keyboardType,
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
              icon,
              color: ColorManager.textSecondary,
              size: AppSize.s20.w,
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

  void _saveAddress() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Create the updated address
      final updatedAddress = PatientAddress(
        street: _streetController.text.trim(),
        city: _cityController.text.trim(),
        state: _stateController.text.trim(),
        zipCode: _postalCodeController.text.trim(),
        country: _countryController.text.trim(),
      );

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Return the updated address
      if (mounted) {
        Navigator.of(context).pop(updatedAddress);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('profile.address.savedSuccessfully'.tr()),
            backgroundColor: ColorManager.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('profile.address.saveError'.tr()),
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

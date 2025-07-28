import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/res/app_res.dart';
import '../../data/models/patient_model.dart';

class ProfileHeader extends StatelessWidget {
  final PatientModel patient;

  const ProfileHeader({
    super.key,
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppPadding.p20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorManager.primary,
            ColorManager.primary.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(AppSize.s16.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.primary.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profile Avatar
          Container(
            width: AppSize.s80.w,
            height: AppSize.s80.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorManager.onPrimary.withOpacity(0.2),
              border: Border.all(
                color: ColorManager.onPrimary,
                width: 3,
              ),
            ),
            child: patient.profileImageUrl != null
                ? ClipOval(
                    child: Image.network(
                      patient.profileImageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildAvatarFallback();
                      },
                    ),
                  )
                : _buildAvatarFallback(),
          ),
          
          SizedBox(height: AppSize.s16.h),
          
          // Patient Name
          Text(
            patient.name,
            style: TextStyleManager.getBoldStyle(
              fontSize: FontSize.s20,
              color: ColorManager.onPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: AppSize.s8.h),
          
          // Patient Email
          Text(
            patient.email,
            style: TextStyleManager.getRegularStyle(
              fontSize: FontSize.s14,
              color: ColorManager.onPrimary.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: AppSize.s16.h),
          
          // Patient Info Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildInfoItem(
                icon: Icons.phone,
                label: 'profile.personalInfo.phone'.tr(),
                value: patient.formattedPhoneNumber,
              ),
              Container(
                width: 1,
                height: AppSize.s40.h,
                color: ColorManager.onPrimary.withOpacity(0.3),
              ),
              _buildInfoItem(
                icon: Icons.cake,
                label: 'profile.personalInfo.age'.tr(),
                value: _calculateAge(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarFallback() {
    return Center(
      child: Text(
        patient.initials,
        style: TextStyleManager.getBoldStyle(
          fontSize: FontSize.s24,
          color: ColorManager.onPrimary,
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            color: ColorManager.onPrimary,
            size: AppSize.s20.w,
          ),
          SizedBox(height: AppSize.s4.h),
          Text(
            label,
            style: TextStyleManager.getRegularStyle(
              fontSize: FontSize.s12,
              color: ColorManager.onPrimary.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSize.s2.h),
          Text(
            value,
            style: TextStyleManager.getSemiBoldStyle(
              fontSize: FontSize.s14,
              color: ColorManager.onPrimary,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  String _calculateAge() {
    if (patient.dateOfBirth == null) {
      return 'profile.personalInfo.ageUnknown'.tr();
    }
    
    final now = DateTime.now();
    final age = now.year - patient.dateOfBirth!.year;
    
    // Check if birthday has occurred this year
    final hasHadBirthdayThisYear = now.month > patient.dateOfBirth!.month ||
        (now.month == patient.dateOfBirth!.month && now.day >= patient.dateOfBirth!.day);
    
    final actualAge = hasHadBirthdayThisYear ? age : age - 1;
    
    return '$actualAge ${'profile.personalInfo.years'.tr()}';
  }
}
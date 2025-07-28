import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/res/app_res.dart';
import '../../../../core/blocs/translate/translate_bloc.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.p20.w),
      decoration: BoxDecoration(
        color: ColorManager.backgroundPrimary,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSize.s20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: AppSize.s40.w,
              height: AppSize.s4.h,
              decoration: BoxDecoration(
                color: ColorManager.textSecondary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(AppSize.s2.r),
              ),
            ),
          ),
          
          SizedBox(height: AppSize.s20.h),
          
          // Title
          Text(
            'profile.settings.selectLanguage'.tr(),
            style: TextStyleManager.getBoldStyle(
              fontSize: FontSize.s18,
              color: ColorManager.textPrimary,
            ),
          ),
          
          SizedBox(height: AppSize.s16.h),
          
          // Language Options
          BlocBuilder<TranslateBloc, TranslateState>(
            builder: (context, state) {
              return Column(
                children: [
                  _buildLanguageOption(
                    context: context,
                    languageCode: 'en',
                    countryCode: 'US',
                    title: 'English',
                    subtitle: 'English (United States)',
                    flag: '🇺🇸',
                    isSelected: state.languageCode == 'en',
                  ),
                  
                  SizedBox(height: AppSize.s8.h),
                  
                  _buildLanguageOption(
                    context: context,
                    languageCode: 'ar',
                    countryCode: 'AR',
                    title: 'العربية',
                    subtitle: 'Arabic',
                    flag: '🇸🇦',
                    isSelected: state.languageCode == 'ar',
                  ),
                ],
              );
            },
          ),
          
          SizedBox(height: AppSize.s20.h),
        ],
      ),
    );
  }

  Widget _buildLanguageOption({
    required BuildContext context,
    required String languageCode,
    required String countryCode,
    required String title,
    required String subtitle,
    required String flag,
    required bool isSelected,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _selectLanguage(context, languageCode, countryCode),
        borderRadius: BorderRadius.circular(AppSize.s12.r),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppPadding.p16.w),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected 
                  ? ColorManager.primary 
                  : ColorManager.textSecondary.withOpacity(0.2),
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(AppSize.s12.r),
            color: isSelected 
                ? ColorManager.primary.withOpacity(0.05)
                : Colors.transparent,
          ),
          child: Row(
            children: [
              // Flag
              Container(
                width: AppSize.s40.w,
                height: AppSize.s40.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorManager.backgroundSecondary,
                ),
                child: Center(
                  child: Text(
                    flag,
                    style: TextStyle(fontSize: FontSize.s20),
                  ),
                ),
              ),
              
              SizedBox(width: AppSize.s12.w),
              
              // Language Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyleManager.getSemiBoldStyle(
                        fontSize: FontSize.s16,
                        color: isSelected 
                            ? ColorManager.primary 
                            : ColorManager.textPrimary,
                      ),
                    ),
                    SizedBox(height: AppSize.s2.h),
                    Text(
                      subtitle,
                      style: TextStyleManager.getRegularStyle(
                        fontSize: FontSize.s12,
                        color: ColorManager.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Selection Indicator
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: ColorManager.primary,
                  size: AppSize.s24.w,
                )
              else
                Icon(
                  Icons.radio_button_unchecked,
                  color: ColorManager.textSecondary.withOpacity(0.5),
                  size: AppSize.s24.w,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectLanguage(BuildContext context, String languageCode, String countryCode) {
    final translateBloc = context.read<TranslateBloc>();
    
    // Update the language in the bloc
    if (languageCode == 'ar') {
      translateBloc.add(TrArabicEvent());
    } else {
      translateBloc.add(TrEnglishEvent());
    }
    
    // Update EasyLocalization
    context.setLocale(Locale(languageCode, countryCode));
    
    // Close the bottom sheet
    Navigator.of(context).pop();
    
    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('profile.settings.languageChanged'.tr()),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
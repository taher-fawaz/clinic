import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/res/app_res.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? titleColor;
  final Color? subtitleColor;
  final bool enabled;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.iconColor,
    this.titleColor,
    this.subtitleColor,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(AppSize.s8.r),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.p16.w,
            vertical: AppPadding.p12.h,
          ),
          child: Row(
            children: [
              // Leading Icon
              Container(
                width: AppSize.s40.w,
                height: AppSize.s40.h,
                decoration: BoxDecoration(
                  color: (iconColor ?? ColorManager.primary).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppSize.s8.r),
                ),
                child: Icon(
                  icon,
                  color: enabled
                      ? (iconColor ?? ColorManager.primary)
                      : ColorManager.textSecondary,
                  size: AppSize.s20.w,
                ),
              ),

              SizedBox(width: AppSize.s12.w),

              // Title and Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyleManager.getSemiBoldStyle(
                        fontSize: FontSize.s14,
                        color: enabled
                            ? (titleColor ?? ColorManager.textPrimary)
                            : ColorManager.textSecondary,
                      ),
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: AppSize.s2.h),
                      Text(
                        subtitle!,
                        style: TextStyleManager.getRegularStyle(
                          fontSize: FontSize.s12,
                          color: enabled
                              ? (subtitleColor ?? ColorManager.textSecondary)
                              : ColorManager.textSecondary.withOpacity(0.6),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),

              // Trailing Widget
              if (trailing != null) ...[
                SizedBox(width: AppSize.s8.w),
                trailing!,
              ] else if (onTap != null && enabled) ...[
                SizedBox(width: AppSize.s8.w),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: ColorManager.textSecondary,
                  size: AppSize.s20.w,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// Specialized menu items for common use cases
class ProfileSwitchMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? iconColor;
  final bool enabled;

  const ProfileSwitchMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.value,
    this.onChanged,
    this.iconColor,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileMenuItem(
      icon: icon,
      title: title,
      subtitle: subtitle,
      iconColor: iconColor,
      enabled: enabled,
      trailing: Switch(
        value: value,
        onChanged: enabled ? onChanged : null,
        activeColor: ColorManager.primary,
      ),
    );
  }
}

class ProfileBadgeMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String badgeText;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? badgeColor;
  final bool enabled;

  const ProfileBadgeMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.badgeText,
    this.onTap,
    this.iconColor,
    this.badgeColor,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileMenuItem(
      icon: icon,
      title: title,
      subtitle: subtitle,
      onTap: onTap,
      iconColor: iconColor,
      enabled: enabled,
      trailing: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.p8.w,
          vertical: AppPadding.p4.h,
        ),
        decoration: BoxDecoration(
          color: badgeColor ?? ColorManager.primary,
          borderRadius: BorderRadius.circular(AppSize.s12.r),
        ),
        child: Text(
          badgeText,
          style: TextStyleManager.getSemiBoldStyle(
            fontSize: FontSize.s10,
            color: ColorManager.onPrimary,
          ),
        ),
      ),
    );
  }
}

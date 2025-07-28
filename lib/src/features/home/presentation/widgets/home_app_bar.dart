import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/res/app_res.dart';

class HomeAppBar extends StatelessWidget {
  final String userName;
  final VoidCallback? onNotificationTap;

  const HomeAppBar({
    super.key,
    required this.userName,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120.h,
      floating: false,
      pinned: true,
      backgroundColor: ColorManager.primary,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'home.welcome'.tr(),
          style: TextStyleManager.getSemiBoldStyle(
            fontSize: FontSize.s18,
            color: ColorManager.onPrimary,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: ColorManager.primaryGradient,
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'مرحباً بك',
                        style: TextStyleManager.getSemiBoldStyle(
                          fontSize: FontSize.s24,
                          color: ColorManager.onPrimary,
                        ),
                      ),
                      Text(
                        userName,
                        style: TextStyleManager.getRegularStyle(
                          fontSize: FontSize.s16,
                          color: ColorManager.onPrimary.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: onNotificationTap,
                    child: Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorManager.onPrimary.withOpacity(0.2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.notifications_outlined,
                        color: ColorManager.onPrimary,
                        size: 24.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/res/app_res.dart';

import '../../data/models/doctor_work_model.dart';
import '../widgets/doctor_work_content.dart';
import '../widgets/doctor_work_header.dart';

class DoctorWorkDetailsScreen extends StatelessWidget {
  final DoctorWorkModel doctorWork;

  const DoctorWorkDetailsScreen({
    super.key,
    required this.doctorWork,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundPrimary,
      body: CustomScrollView(
        slivers: [
          DoctorWorkHeader(doctorWork: doctorWork),
          DoctorWorkContent(doctorWork: doctorWork),

          // Related Doctor Works Section (Placeholder)
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: ColorManager.surface,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.shadowColor.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          gradient: ColorManager.secondaryGradient,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.work_outline,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        'أعمال مشابهة',
                        style: TextStyleManager.getBoldStyle(
                          fontSize: FontSize.s18,
                          color: ColorManager.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    height: 100.h,
                    decoration: BoxDecoration(
                      color: ColorManager.backgroundSecondary,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: ColorManager.border,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.work_outline,
                            size: 32.sp,
                            color: ColorManager.textSecondary,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'أعمال مشابهة قريباً',
                            style: TextStyleManager.getRegularStyle(
                              fontSize: FontSize.s14,
                              color: ColorManager.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Back to Works Button
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(20.w),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 24.w,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        ColorManager.primary.withOpacity(0.1),
                        ColorManager.secondary.withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: ColorManager.primary.withOpacity(0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.shadowColor.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: ColorManager.primary,
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'العودة إلى الأعمال',
                        style: TextStyleManager.getSemiBoldStyle(
                          fontSize: FontSize.s16,
                          color: ColorManager.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(height: 20.h),
          ),
        ],
      ),
    );
  }
}

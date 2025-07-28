import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/res/app_res.dart';

import '../../data/models/doctor_work_model.dart';

class DoctorWorkContent extends StatelessWidget {
  final DoctorWorkModel doctorWork;

  const DoctorWorkContent({
    super.key,
    required this.doctorWork,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: ColorManager.backgroundPrimary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Treatment Type and Duration
            Container(
              margin: EdgeInsets.all(20.w),
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
                  Text(
                    'تفاصيل العلاج',
                    style: TextStyleManager.getBoldStyle(
                      fontSize: FontSize.s18,
                      color: ColorManager.textPrimary,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _InfoRow(
                    icon: Icons.medical_services_outlined,
                    label: 'نوع العلاج',
                    value: doctorWork.treatmentType,
                  ),
                  SizedBox(height: 12.h),
                  _InfoRow(
                    icon: Icons.schedule_outlined,
                    label: 'مدة العلاج',
                    value: doctorWork.duration,
                  ),
                  SizedBox(height: 12.h),
                  _InfoRow(
                    icon: Icons.person_outline,
                    label: 'الطبيب المعالج',
                    value: 'د. ${doctorWork.doctorName}',
                  ),
                  SizedBox(height: 12.h),
                  _InfoRow(
                    icon: Icons.category_outlined,
                    label: 'التخصص',
                    value: doctorWork.specialty,
                  ),
                ],
              ),
            ),

            // Description Section
            Container(
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
                          gradient: ColorManager.primaryGradient,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.description_outlined,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        'وصف الحالة',
                        style: TextStyleManager.getBoldStyle(
                          fontSize: FontSize.s18,
                          color: ColorManager.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    doctorWork.description,
                    style: TextStyleManager.getRegularStyle(
                      fontSize: FontSize.s16,
                      color: ColorManager.textSecondary,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),

            // Before/After Comparison Section
            Container(
              margin: EdgeInsets.all(20.w),
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
                          Icons.compare_outlined,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        'مقارنة قبل وبعد العلاج',
                        style: TextStyleManager.getBoldStyle(
                          fontSize: FontSize.s18,
                          color: ColorManager.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: _ComparisonImage(
                          imageUrl: doctorWork.beforeImageUrl,
                          label: 'قبل العلاج',
                          color: ColorManager.error,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: _ComparisonImage(
                          imageUrl: doctorWork.afterImageUrl,
                          label: 'بعد العلاج',
                          color: ColorManager.success,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Doctor Information Section
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    ColorManager.primary.withOpacity(0.05),
                    ColorManager.secondary.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: ColorManager.primary.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          gradient: ColorManager.primaryGradient,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.person_outlined,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        'معلومات الطبيب',
                        style: TextStyleManager.getBoldStyle(
                          fontSize: FontSize.s18,
                          color: ColorManager.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'د. ${doctorWork.doctorName}',
                    style: TextStyleManager.getSemiBoldStyle(
                      fontSize: FontSize.s16,
                      color: ColorManager.primary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    doctorWork.specialty,
                    style: TextStyleManager.getRegularStyle(
                      fontSize: FontSize.s14,
                      color: ColorManager.textSecondary,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 16.w,
                    ),
                    decoration: BoxDecoration(
                      gradient: ColorManager.primaryGradient,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: ColorManager.primary.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.white,
                          size: 18.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'احجز موعد مع الطبيب',
                          style: TextStyleManager.getSemiBoldStyle(
                            fontSize: FontSize.s14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: ColorManager.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Icon(
            icon,
            color: ColorManager.primary,
            size: 16.sp,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyleManager.getRegularStyle(
                  fontSize: FontSize.s12,
                  color: ColorManager.textSecondary,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: TextStyleManager.getSemiBoldStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ComparisonImage extends StatelessWidget {
  final String imageUrl;
  final String label;
  final Color color;

  const _ComparisonImage({
    required this.imageUrl,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: color.withOpacity(0.3),
              width: 2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: ColorManager.backgroundSecondary,
                  child: Center(
                    child: Icon(
                      Icons.image_outlined,
                      size: 40.sp,
                      color: ColorManager.textSecondary,
                    ),
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: ColorManager.backgroundSecondary,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                      color: color,
                      strokeWidth: 2,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 6.h,
          ),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: color.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Text(
            label,
            style: TextStyleManager.getSemiBoldStyle(
              fontSize: FontSize.s12,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

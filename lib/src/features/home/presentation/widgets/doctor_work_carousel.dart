import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/res/app_res.dart';
import '../../data/models/doctor_work_model.dart';

class DoctorWorkCarousel extends StatelessWidget {
  final List<DoctorWorkModel> doctorWorks;
  final VoidCallback? onViewAll;

  const DoctorWorkCarousel({
    super.key,
    required this.doctorWorks,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'home.doctorWork.title'.tr(),
                style: TextStyleManager.getBoldStyle(
                  fontSize: FontSize.s18,
                  color: ColorManager.textPrimary,
                ),
              ),
              if (onViewAll != null)
                GestureDetector(
                  onTap: onViewAll,
                  child: Text(
                    'home.doctorWork.viewAll'.tr(),
                    style: TextStyleManager.getMediumStyle(
                      fontSize: FontSize.s14,
                      color: ColorManager.primary,
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 300.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: doctorWorks.length,
            itemBuilder: (context, index) {
              final work = doctorWorks[index];
              return Container(
                width: 300.w,
                margin: EdgeInsets.only(right: 16.w),
                child: _DoctorWorkCard(work: work),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _DoctorWorkCard extends StatelessWidget {
  final DoctorWorkModel work;

  const _DoctorWorkCard({required this.work});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.shadowColor,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Before/After Images
          Container(
            height: 180.h,
            child: Row(
              children: [
                Expanded(
                  child: _ImageSection(
                    imageUrl: work.beforeImageUrl,
                    label: 'home.doctorWork.before'.tr(),
                  ),
                ),
                Container(
                  width: 1,
                  color: ColorManager.border,
                ),
                Expanded(
                  child: _ImageSection(
                    imageUrl: work.afterImageUrl,
                    label: 'home.doctorWork.after'.tr(),
                  ),
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    work.title,
                    style: TextStyleManager.getSemiBoldStyle(
                      fontSize: FontSize.s16,
                      color: ColorManager.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    work.description,
                    style: TextStyleManager.getRegularStyle(
                      fontSize: FontSize.s12,
                      color: ColorManager.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${'home.doctorWork.by'.tr()} ${work.doctorName}',
                        style: TextStyleManager.getMediumStyle(
                          fontSize: FontSize.s12,
                          color: ColorManager.primary,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: ColorManager.primaryLight.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          work.specialty,
                          style: TextStyleManager.getRegularStyle(
                            fontSize: FontSize.s10,
                            color: ColorManager.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageSection extends StatelessWidget {
  final String imageUrl;
  final String label;

  const _ImageSection({
    required this.imageUrl,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorManager.backgroundSecondary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.r),
                      topRight: Radius.circular(16.r),
                    ),
                  ),
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
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorManager.backgroundSecondary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.r),
                      topRight: Radius.circular(16.r),
                    ),
                  ),
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                      color: ColorManager.primary,
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 8.h,
            left: 8.w,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 4.h,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                label,
                style: TextStyleManager.getMediumStyle(
                  fontSize: FontSize.s10,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

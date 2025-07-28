import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/res/app_res.dart';
import '../../data/models/available_slot_model.dart';

class BookButton extends StatelessWidget {
  final AvailableSlotModel? selectedSlot;
  final DateTime? selectedDate;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;

  const BookButton({
    super.key,
    this.selectedSlot,
    this.selectedDate,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final canBook = selectedSlot != null && selectedDate != null && isEnabled;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        boxShadow: [
          BoxShadow(
            color: ColorManager.shadowColor,
            blurRadius: 12.r,
            offset: Offset(0, -4.h),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selectedSlot != null) _buildBookingSummary(),
            SizedBox(height: 16.h),
            _buildBookButton(canBook),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingSummary() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.backgroundSecondary,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: ColorManager.primary.withOpacity(0.2),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'appointment.bookingSummary'.tr(),
            style: TextStyleManager.getSemiBoldStyle(
              fontSize: FontSize.s16,
              color: ColorManager.textPrimary,
            ),
          ),
          SizedBox(height: 12.h),

          _buildSummaryRow(
            'appointment.date'.tr(),
            DateFormat('EEEE, MMM dd, yyyy').format(selectedDate!),
          ),
          SizedBox(height: 8.h),
          _buildSummaryRow(
            'appointment.time'.tr(),
            selectedSlot!.timeRange,
          ),
          SizedBox(height: 8.h),
          _buildSummaryRow(
            'appointment.duration'.tr(),
            '${selectedSlot!.durationMinutes} ${'appointment.minutes'.tr()}',
          ),
          Divider(
            height: 24.h,
            color: ColorManager.border,
          ),
          _buildSummaryRow(
            'appointment.totalPrice'.tr(),
            selectedSlot!.formattedPrice,
            isPrice: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isPrice = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyleManager.getRegularStyle(
            fontSize: FontSize.s14,
            color: ColorManager.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyleManager.getMediumStyle(
            fontSize: isPrice ? FontSize.s16 : FontSize.s14,
            color: isPrice ? ColorManager.success : ColorManager.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildBookButton(bool canBook) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: canBook && !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: canBook ? ColorManager.primary : ColorManager.surfaceVariant,
          foregroundColor: canBook ? ColorManager.onPrimary : ColorManager.textTertiary,
          elevation: canBook ? 4 : 0,
          shadowColor: ColorManager.primary.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          disabledBackgroundColor: ColorManager.surfaceVariant,
          disabledForegroundColor: ColorManager.textTertiary,
        ),
        child: isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20.w,
                    height: 20.h,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.w,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        ColorManager.onPrimary,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'appointment.booking'.tr(),
                    style: TextStyleManager.getSemiBoldStyle(
                      fontSize: FontSize.s16,
                      color: ColorManager.onPrimary,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 20.sp,
                    color: canBook ? ColorManager.onPrimary : ColorManager.textTertiary,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    canBook
                        ? 'appointment.bookNow'.tr()
                        : 'appointment.selectSlot'.tr(),
                    style: TextStyleManager.getSemiBoldStyle(
                      fontSize: FontSize.s16,
                      color: canBook ? ColorManager.onPrimary : ColorManager.textTertiary,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
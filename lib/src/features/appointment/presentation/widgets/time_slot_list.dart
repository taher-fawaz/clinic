import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/res/app_res.dart';
import '../../data/models/available_slot_model.dart';

class TimeSlotList extends StatefulWidget {
  final List<AvailableSlotModel> timeSlots;
  final AvailableSlotModel? selectedSlot;
  final Function(AvailableSlotModel) onSlotSelected;
  final bool isLoading;
  final String? errorMessage;

  const TimeSlotList({
    super.key,
    required this.timeSlots,
    this.selectedSlot,
    required this.onSlotSelected,
    this.isLoading = false,
    this.errorMessage,
  });

  @override
  State<TimeSlotList> createState() => _TimeSlotListState();
}

class _TimeSlotListState extends State<TimeSlotList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.surface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.shadowColor,
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: 16.h),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'appointment.availableSlots'.tr(),
          style: TextStyleManager.getSemiBoldStyle(
            fontSize: FontSize.s18,
            color: ColorManager.textPrimary,
          ),
        ),
        if (widget.timeSlots.isNotEmpty && !widget.isLoading)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: ColorManager.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              '${widget.timeSlots.length} ${'appointment.slotsAvailable'.tr()}',
              style: TextStyleManager.getRegularStyle(
                fontSize: FontSize.s12,
                color: ColorManager.success,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildContent() {
    if (widget.isLoading) {
      return _buildLoadingState();
    }

    if (widget.errorMessage != null) {
      return _buildErrorState();
    }

    if (widget.timeSlots.isEmpty) {
      return _buildEmptyState();
    }

    return _buildTimeSlotGrid();
  }

  Widget _buildLoadingState() {
    return Container(
      height: 200.h,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: ColorManager.primary,
              strokeWidth: 2.w,
            ),
            SizedBox(height: 16.h),
            Text(
              'appointment.loadingSlots'.tr(),
              style: TextStyleManager.getRegularStyle(
                fontSize: FontSize.s14,
                color: ColorManager.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Container(
      height: 200.h,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48.sp,
              color: ColorManager.error,
            ),
            SizedBox(height: 16.h),
            Text(
              widget.errorMessage!,
              textAlign: TextAlign.center,
              style: TextStyleManager.getRegularStyle(
                fontSize: FontSize.s14,
                color: ColorManager.error,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: 200.h,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.schedule,
              size: 48.sp,
              color: ColorManager.textTertiary,
            ),
            SizedBox(height: 16.h),
            Text(
              'appointment.noSlotsAvailable'.tr(),
              textAlign: TextAlign.center,
              style: TextStyleManager.getRegularStyle(
                fontSize: FontSize.s16,
                color: ColorManager.textSecondary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'appointment.selectDifferentDate'.tr(),
              textAlign: TextAlign.center,
              style: TextStyleManager.getRegularStyle(
                fontSize: FontSize.s14,
                color: ColorManager.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSlotGrid() {
    // Filter only available slots
    final availableSlots =
        widget.timeSlots.where((slot) => slot.isAvailable).toList();
    final unavailableSlots =
        widget.timeSlots.where((slot) => !slot.isAvailable).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (availableSlots.isNotEmpty) ...[
          Text(
            'appointment.availableSlots'.tr(),
            style: TextStyleManager.getMediumStyle(
              fontSize: FontSize.s16,
              color: ColorManager.textPrimary,
            ),
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children:
                availableSlots.map((slot) => _buildTimeSlotCard(slot)).toList(),
          ),
        ],
        if (unavailableSlots.isNotEmpty) ...[
          if (availableSlots.isNotEmpty) SizedBox(height: 24.h),
          Text(
            'appointment.booked'.tr(),
            style: TextStyleManager.getMediumStyle(
              fontSize: FontSize.s16,
              color: ColorManager.textSecondary,
            ),
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: unavailableSlots
                .map((slot) => _buildTimeSlotCard(slot))
                .toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildTimeSlotCard(AvailableSlotModel slot) {
    final isSelected = widget.selectedSlot?.id == slot.id;
    final isAvailable = slot.isAvailable;

    return GestureDetector(
      onTap: isAvailable ? () => widget.onSlotSelected(slot) : null,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorManager.primary
              : isAvailable
                  ? ColorManager.surface
                  : ColorManager.surfaceVariant,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected
                ? ColorManager.primary
                : isAvailable
                    ? ColorManager.border
                    : ColorManager.borderError,
            width: isSelected ? 2.w : 1.w,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              slot.timeRange,
              style: TextStyleManager.getMediumStyle(
                fontSize: FontSize.s14,
                color: isSelected
                    ? ColorManager.onPrimary
                    : isAvailable
                        ? ColorManager.textPrimary
                        : ColorManager.textTertiary,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              slot.formattedPrice,
              style: TextStyleManager.getRegularStyle(
                fontSize: FontSize.s12,
                color: isSelected
                    ? ColorManager.onPrimary
                    : isAvailable
                        ? ColorManager.success
                        : ColorManager.textTertiary,
              ),
            ),
            if (!isAvailable) ...[
              SizedBox(height: 4.h),
              Text(
                'appointment.booked'.tr(),
                style: TextStyleManager.getRegularStyle(
                  fontSize: FontSize.s10,
                  color: ColorManager.error,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

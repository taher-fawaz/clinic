import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/res/app_res.dart';
import '../../data/models/appointment_status_model.dart';
import '../../data/models/appointment_history_model.dart';

class AppointmentCard extends StatelessWidget {
  final String appointmentId;
  final String doctorName;
  final String specialty;
  final DateTime appointmentDate;
  final String timeRange;
  final String formattedPrice;
  final AppointmentStatus? status;
  final VisitType? visitType;
  final String? notes;
  final VoidCallback? onTap;
  final bool showStatus;
  final bool showVisitType;
  final int? rating;

  const AppointmentCard({
    Key? key,
    required this.appointmentId,
    required this.doctorName,
    required this.specialty,
    required this.appointmentDate,
    required this.timeRange,
    required this.formattedPrice,
    this.status,
    this.visitType,
    this.notes,
    this.onTap,
    this.showStatus = false,
    this.showVisitType = false,
    this.rating,
  }) : super(key: key);

  // Factory constructor for status appointments
  factory AppointmentCard.fromStatus({
    required AppointmentStatusModel appointment,
    VoidCallback? onTap,
  }) {
    return AppointmentCard(
      appointmentId: appointment.appointmentId,
      doctorName: appointment.doctorName,
      specialty: appointment.specialty,
      appointmentDate: appointment.appointmentDate,
      timeRange: appointment.timeRange,
      formattedPrice: appointment.formattedPrice,
      status: appointment.status,
      notes: appointment.notes,
      onTap: onTap,
      showStatus: true,
    );
  }

  // Factory constructor for history appointments
  factory AppointmentCard.fromHistory({
    required AppointmentHistoryModel appointment,
    VoidCallback? onTap,
  }) {
    return AppointmentCard(
      appointmentId: appointment.appointmentId,
      doctorName: appointment.doctorName,
      specialty: appointment.specialty,
      appointmentDate: appointment.appointmentDate,
      timeRange: appointment.timeRange,
      formattedPrice: appointment.formattedPrice,
      visitType: appointment.visitType,
      notes: appointment.notes,
      onTap: onTap,
      showVisitType: true,
      rating: appointment.rating,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: ColorManager.surface,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: _getBorderColor(),
                width: 1.w,
              ),
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
                SizedBox(height: 12.h),
                _buildAppointmentInfo(),
                if (showStatus && status != null) ...[
                  SizedBox(height: 12.h),
                  _buildStatusChip(),
                ],
                if (showVisitType && visitType != null) ...[
                  SizedBox(height: 12.h),
                  _buildVisitTypeChip(),
                ],
                if (notes != null && notes!.isNotEmpty) ...[
                  SizedBox(height: 12.h),
                  _buildNotes(),
                ],
                if (rating != null && rating! > 0) ...[
                  SizedBox(height: 12.h),
                  _buildRating(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            color: ColorManager.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            Icons.person,
            color: ColorManager.primary,
            size: 24.sp,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctorName,
                style: TextStyleManager.getSemiBoldStyle(
                  fontSize: FontSize.s16,
                  color: ColorManager.textPrimary,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                specialty,
                style: TextStyleManager.getRegularStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Text(
          formattedPrice,
          style: TextStyleManager.getSemiBoldStyle(
            fontSize: FontSize.s16,
            color: ColorManager.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildAppointmentInfo() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorManager.backgroundSecondary,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.calendar_today,
            color: ColorManager.textSecondary,
            size: 16.sp,
          ),
          SizedBox(width: 8.w),
          Text(
            '${appointmentDate.day}/${appointmentDate.month}/${appointmentDate.year}',
            style: TextStyleManager.getRegularStyle(
              fontSize: FontSize.s14,
              color: ColorManager.textPrimary,
            ),
          ),
          SizedBox(width: 16.w),
          Icon(
            Icons.access_time,
            color: ColorManager.textSecondary,
            size: 16.sp,
          ),
          SizedBox(width: 8.w),
          Text(
            timeRange,
            style: TextStyleManager.getRegularStyle(
              fontSize: FontSize.s14,
              color: ColorManager.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: _getStatusColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: _getStatusColor(),
          width: 1.w,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getStatusIcon(),
            color: _getStatusColor(),
            size: 16.sp,
          ),
          SizedBox(width: 6.w),
          Text(
            _getStatusText(),
            style: TextStyleManager.getMediumStyle(
              fontSize: FontSize.s12,
              color: _getStatusColor(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisitTypeChip() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: ColorManager.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: ColorManager.primary,
          width: 1.w,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getVisitTypeIcon(),
            color: ColorManager.primary,
            size: 16.sp,
          ),
          SizedBox(width: 6.w),
          Text(
            _getVisitTypeText(),
            style: TextStyleManager.getMediumStyle(
              fontSize: FontSize.s12,
              color: ColorManager.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotes() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorManager.backgroundSecondary,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.note,
            color: ColorManager.textSecondary,
            size: 16.sp,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              notes!,
              style: TextStyleManager.getRegularStyle(
                fontSize: FontSize.s14,
                color: ColorManager.textPrimary,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRating() {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: ColorManager.textSecondary,
          size: 16.sp,
        ),
        SizedBox(width: 8.w),
        Text(
          'appointment.rating'.tr(),
          style: TextStyleManager.getRegularStyle(
            fontSize: FontSize.s14,
            color: ColorManager.textSecondary,
          ),
        ),
        SizedBox(width: 8.w),
        Row(
          children: List.generate(5, (index) {
            return Icon(
              index < rating! ? Icons.star : Icons.star_border,
              color:
                  index < rating! ? Colors.amber : ColorManager.textSecondary,
              size: 16.sp,
            );
          }),
        ),
      ],
    );
  }

  Color _getBorderColor() {
    if (showStatus && status != null) {
      return _getStatusColor().withOpacity(0.3);
    }
    return ColorManager.border;
  }

  Color _getStatusColor() {
    switch (status) {
      case AppointmentStatus.pending:
        return Colors.orange;
      case AppointmentStatus.approved:
        return ColorManager.success;
      case AppointmentStatus.rejected:
        return ColorManager.error;
      default:
        return ColorManager.textSecondary;
    }
  }

  IconData _getStatusIcon() {
    switch (status) {
      case AppointmentStatus.pending:
        return Icons.schedule;
      case AppointmentStatus.approved:
        return Icons.check_circle;
      case AppointmentStatus.rejected:
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  String _getStatusText() {
    switch (status) {
      case AppointmentStatus.pending:
        return 'appointment.status.pending'.tr();
      case AppointmentStatus.approved:
        return 'appointment.status.approved'.tr();
      case AppointmentStatus.rejected:
        return 'appointment.status.rejected'.tr();
      default:
        return '';
    }
  }

  IconData _getVisitTypeIcon() {
    switch (visitType) {
      case VisitType.consultation:
        return Icons.medical_services;
      case VisitType.followUp:
        return Icons.refresh;
      case VisitType.checkup:
        return Icons.health_and_safety;
      case VisitType.emergency:
        return Icons.emergency;
      case VisitType.procedure:
        return Icons.healing;
      default:
        return Icons.medical_services;
    }
  }

  String _getVisitTypeText() {
    switch (visitType) {
      case VisitType.consultation:
        return 'appointment.visitType.consultation'.tr();
      case VisitType.followUp:
        return 'appointment.visitType.followUp'.tr();
      case VisitType.checkup:
        return 'appointment.visitType.checkup'.tr();
      case VisitType.emergency:
        return 'appointment.visitType.emergency'.tr();
      case VisitType.procedure:
        return 'appointment.visitType.procedure'.tr();
      default:
        return '';
    }
  }
}

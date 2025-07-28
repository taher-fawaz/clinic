import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/res/app_res.dart';
import '../../data/models/appointment_status_model.dart';
import '../widgets/appointment_card.dart';

class AppointmentStatusScreen extends StatefulWidget {
  const AppointmentStatusScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentStatusScreen> createState() =>
      _AppointmentStatusScreenState();
}

class _AppointmentStatusScreenState extends State<AppointmentStatusScreen> {
  bool _isLoading = true;
  List<AppointmentStatusModel> _appointments = [];
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  Future<void> _loadAppointments() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // Mock data - replace with actual API call
      final mockAppointments = _generateMockAppointments();

      setState(() {
        _appointments = mockAppointments;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'appointment.errorLoadingAppointments'.tr();
        _isLoading = false;
      });
    }
  }

  List<AppointmentStatusModel> _generateMockAppointments() {
    final now = DateTime.now();
    return [
      AppointmentStatusModel(
        appointmentId: 'APT001',
        patientId: 'PAT001',
        doctorId: 'DOC001',
        doctorName: 'Dr. Ahmed Hassan',
        specialty: 'Cardiology',
        appointmentDate: now.add(const Duration(days: 2)),
        startTime: '09:00',
        endTime: '09:30',
        status: AppointmentStatus.approved,
        price: 150.0,
        appointmentType: 'Consultation',
        notes: 'Regular checkup appointment',
        createdAt: now.subtract(const Duration(days: 1)),
      ),
      AppointmentStatusModel(
        appointmentId: 'APT002',
        patientId: 'PAT001',
        doctorId: 'DOC002',
        doctorName: 'Dr. Sarah Mohamed',
        specialty: 'Dermatology',
        appointmentDate: now.add(const Duration(days: 5)),
        startTime: '14:00',
        endTime: '14:30',
        status: AppointmentStatus.pending,
        price: 120.0,
        appointmentType: 'Consultation',
        notes: 'Skin consultation',
        createdAt: now.subtract(const Duration(hours: 12)),
      ),
      AppointmentStatusModel(
        appointmentId: 'APT003',
        patientId: 'PAT001',
        doctorId: 'DOC003',
        doctorName: 'Dr. Omar Ali',
        specialty: 'Orthopedics',
        appointmentDate: now.add(const Duration(days: 1)),
        startTime: '11:00',
        endTime: '11:30',
        status: AppointmentStatus.rejected,
        price: 200.0,
        appointmentType: 'Consultation',
        notes: 'Knee pain examination - Doctor unavailable',
        createdAt: now.subtract(const Duration(days: 2)),
        rejectionReason: 'Doctor unavailable at requested time',
      ),
      AppointmentStatusModel(
        appointmentId: 'APT004',
        patientId: 'PAT001',
        doctorId: 'DOC004',
        doctorName: 'Dr. Fatima Nasser',
        specialty: 'Pediatrics',
        appointmentDate: now.add(const Duration(days: 7)),
        startTime: '10:00',
        endTime: '10:30',
        status: AppointmentStatus.pending,
        price: 100.0,
        appointmentType: 'Vaccination',
        notes: 'Child vaccination',
        createdAt: now.subtract(const Duration(hours: 6)),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundPrimary,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: ColorManager.surface,
      elevation: 0,
      title: Text(
        'appointment.status.title'.tr(),
        style: TextStyleManager.getSemiBoldStyle(
          fontSize: FontSize.s18,
          color: ColorManager.textPrimary,
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: ColorManager.textPrimary,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.refresh,
            color: ColorManager.primary,
          ),
          onPressed: _loadAppointments,
        ),
      ],
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return _buildLoadingState();
    }

    if (_errorMessage != null) {
      return _buildErrorState();
    }

    if (_appointments.isEmpty) {
      return _buildEmptyState();
    }

    return _buildAppointmentsList();
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: ColorManager.primary,
          ),
          SizedBox(height: 16.h),
          Text(
            'appointment.loadingAppointments'.tr(),
            style: TextStyleManager.getRegularStyle(
              fontSize: FontSize.s16,
              color: ColorManager.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64.sp,
              color: ColorManager.error,
            ),
            SizedBox(height: 16.h),
            Text(
              _errorMessage!,
              style: TextStyleManager.getRegularStyle(
                fontSize: FontSize.s16,
                color: ColorManager.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: _loadAppointments,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primary,
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'common.retry'.tr(),
                style: TextStyleManager.getMediumStyle(
                  fontSize: FontSize.s14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_busy,
              size: 64.sp,
              color: ColorManager.textSecondary,
            ),
            SizedBox(height: 16.h),
            Text(
              'appointment.noAppointments'.tr(),
              style: TextStyleManager.getSemiBoldStyle(
                fontSize: FontSize.s18,
                color: ColorManager.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              'appointment.noAppointmentsDescription'.tr(),
              style: TextStyleManager.getRegularStyle(
                fontSize: FontSize.s14,
                color: ColorManager.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentsList() {
    // Group appointments by status
    final pendingAppointments = _appointments
        .where((apt) => apt.status == AppointmentStatus.pending)
        .toList();
    final approvedAppointments = _appointments
        .where((apt) => apt.status == AppointmentStatus.approved)
        .toList();
    final rejectedAppointments = _appointments
        .where((apt) => apt.status == AppointmentStatus.rejected)
        .toList();

    return RefreshIndicator(
      onRefresh: _loadAppointments,
      color: ColorManager.primary,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusSummary(),
            SizedBox(height: 24.h),
            if (pendingAppointments.isNotEmpty) ...[
              _buildSectionHeader(
                'appointment.status.pending'.tr(),
                pendingAppointments.length,
                Colors.orange,
              ),
              SizedBox(height: 12.h),
              ...pendingAppointments.map(
                (appointment) => AppointmentCard.fromStatus(
                  appointment: appointment,
                  onTap: () => _showAppointmentDetails(appointment),
                ),
              ),
              SizedBox(height: 24.h),
            ],
            if (approvedAppointments.isNotEmpty) ...[
              _buildSectionHeader(
                'appointment.status.approved'.tr(),
                approvedAppointments.length,
                ColorManager.success,
              ),
              SizedBox(height: 12.h),
              ...approvedAppointments.map(
                (appointment) => AppointmentCard.fromStatus(
                  appointment: appointment,
                  onTap: () => _showAppointmentDetails(appointment),
                ),
              ),
              SizedBox(height: 24.h),
            ],
            if (rejectedAppointments.isNotEmpty) ...[
              _buildSectionHeader(
                'appointment.status.rejected'.tr(),
                rejectedAppointments.length,
                ColorManager.error,
              ),
              SizedBox(height: 12.h),
              ...rejectedAppointments.map(
                (appointment) => AppointmentCard.fromStatus(
                  appointment: appointment,
                  onTap: () => _showAppointmentDetails(appointment),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusSummary() {
    final pendingCount = _appointments
        .where((apt) => apt.status == AppointmentStatus.pending)
        .length;
    final approvedCount = _appointments
        .where((apt) => apt.status == AppointmentStatus.approved)
        .length;
    final rejectedCount = _appointments
        .where((apt) => apt.status == AppointmentStatus.rejected)
        .length;

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
          Text(
            'appointment.summary'.tr(),
            style: TextStyleManager.getSemiBoldStyle(
              fontSize: FontSize.s16,
              color: ColorManager.textPrimary,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  'appointment.status.pending'.tr(),
                  pendingCount,
                  Colors.orange,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildSummaryItem(
                  'appointment.status.approved'.tr(),
                  approvedCount,
                  ColorManager.success,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildSummaryItem(
                  'appointment.status.rejected'.tr(),
                  rejectedCount,
                  ColorManager.error,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, int count, Color color) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1.w,
        ),
      ),
      child: Column(
        children: [
          Text(
            count.toString(),
            style: TextStyleManager.getBoldStyle(
              fontSize: FontSize.s20,
              color: color,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyleManager.getRegularStyle(
              fontSize: FontSize.s12,
              color: ColorManager.textSecondary,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, int count, Color color) {
    return Row(
      children: [
        Container(
          width: 4.w,
          height: 20.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          title,
          style: TextStyleManager.getSemiBoldStyle(
            fontSize: FontSize.s16,
            color: ColorManager.textPrimary,
          ),
        ),
        SizedBox(width: 8.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            count.toString(),
            style: TextStyleManager.getMediumStyle(
              fontSize: FontSize.s12,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  void _showAppointmentDetails(AppointmentStatusModel appointment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildAppointmentDetailsSheet(appointment),
    );
  }

  Widget _buildAppointmentDetailsSheet(AppointmentStatusModel appointment) {
    return Container(
      margin: EdgeInsets.only(top: 100.h),
      decoration: BoxDecoration(
        color: ColorManager.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: ColorManager.border,
                  width: 1.w,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'appointment.details'.tr(),
                    style: TextStyleManager.getSemiBoldStyle(
                      fontSize: FontSize.s18,
                      color: ColorManager.textPrimary,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.close,
                    color: ColorManager.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppointmentCard.fromStatus(
                    appointment: appointment,
                  ),
                  SizedBox(height: 20.h),
                  _buildDetailItem(
                    'appointment.appointmentId'.tr(),
                    appointment.appointmentId,
                  ),
                  _buildDetailItem(
                    'appointment.createdAt'.tr(),
                    appointment.formattedCreatedAt,
                  ),
                  if (appointment.notes != null &&
                      appointment.notes!.isNotEmpty)
                    _buildDetailItem(
                      'appointment.notes'.tr(),
                      appointment.notes!,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyleManager.getMediumStyle(
              fontSize: FontSize.s14,
              color: ColorManager.textSecondary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyleManager.getRegularStyle(
              fontSize: FontSize.s16,
              color: ColorManager.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/res/app_res.dart';
import '../../data/models/appointment_history_model.dart';
import '../widgets/appointment_card.dart';

class AppointmentHistoryScreen extends StatefulWidget {
  const AppointmentHistoryScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentHistoryScreen> createState() =>
      _AppointmentHistoryScreenState();
}

class _AppointmentHistoryScreenState extends State<AppointmentHistoryScreen> {
  bool _isLoading = true;
  List<AppointmentHistoryModel> _appointments = [];
  String? _errorMessage;
  String _selectedFilter = 'all';
  final List<String> _filterOptions = [
    'all',
    'consultation',
    'followUp',
    'checkup',
    'emergency',
    'procedure'
  ];

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
        _errorMessage = 'appointment.errorLoadingHistory'.tr();
        _isLoading = false;
      });
    }
  }

  List<AppointmentHistoryModel> _generateMockAppointments() {
    final now = DateTime.now();
    return [
      AppointmentHistoryModel(
        appointmentId: 'APT101',
        patientId: 'PAT001',
        doctorId: 'DOC001',
        doctorName: 'Dr. Ahmed Hassan',
        specialty: 'Cardiology',
        appointmentDate: now.subtract(const Duration(days: 7)),
        startTime: '09:00',
        endTime: '09:30',
        visitType: VisitType.consultation,
        price: 150.0,
        notes: 'Regular heart checkup completed successfully',
        diagnosis: 'Normal heart rhythm, blood pressure within normal range',
        prescription: 'Continue current medication, follow-up in 3 months',
        followUpInstructions:
            'Monitor blood pressure daily, maintain healthy diet',
        completedAt: now.subtract(const Duration(days: 7)),
        rating: 5,
        patientFeedback: 'Excellent service and professional care',
        attachments: ['ecg_report.pdf', 'blood_test_results.pdf'],
      ),
      AppointmentHistoryModel(
        appointmentId: 'APT102',
        patientId: 'PAT001',
        doctorId: 'DOC002',
        doctorName: 'Dr. Sarah Mohamed',
        specialty: 'Dermatology',
        appointmentDate: now.subtract(const Duration(days: 14)),
        startTime: '14:00',
        endTime: '14:30',
        visitType: VisitType.followUp,
        price: 120.0,
        notes: 'Follow-up for skin treatment',
        diagnosis: 'Skin condition improving, treatment effective',
        prescription: 'Continue topical cream for 2 more weeks',
        followUpInstructions: 'Apply cream twice daily, avoid sun exposure',
        completedAt: now.subtract(const Duration(days: 14)),
        rating: 4,
        patientFeedback: 'Good improvement in skin condition',
        attachments: ['skin_photos.jpg'],
      ),
      AppointmentHistoryModel(
        appointmentId: 'APT103',
        patientId: 'PAT001',
        doctorId: 'DOC003',
        doctorName: 'Dr. Omar Ali',
        specialty: 'Orthopedics',
        appointmentDate: now.subtract(const Duration(days: 21)),
        startTime: '11:00',
        endTime: '11:30',
        visitType: VisitType.checkup,
        price: 200.0,
        notes: 'Knee pain examination and X-ray review',
        diagnosis: 'Mild arthritis, no major structural damage',
        prescription: 'Anti-inflammatory medication, physiotherapy',
        followUpInstructions:
            'Physical therapy 3 times per week, avoid heavy lifting',
        completedAt: now.subtract(const Duration(days: 21)),
        rating: 5,
        patientFeedback: 'Very thorough examination and clear explanation',
        attachments: ['xray_knee.jpg', 'physiotherapy_plan.pdf'],
      ),
      AppointmentHistoryModel(
        appointmentId: 'APT104',
        patientId: 'PAT001',
        doctorId: 'DOC004',
        doctorName: 'Dr. Fatima Nasser',
        specialty: 'Pediatrics',
        appointmentDate: now.subtract(const Duration(days: 30)),
        startTime: '10:00',
        endTime: '10:30',
        visitType: VisitType.procedure,
        price: 100.0,
        notes: 'Child vaccination - MMR and Hepatitis B',
        diagnosis: 'Healthy child, vaccinations administered successfully',
        prescription: 'No medication required',
        followUpInstructions:
            'Monitor for any allergic reactions, next vaccination in 6 months',
        completedAt: now.subtract(const Duration(days: 30)),
        rating: 5,
        patientFeedback: 'Child was comfortable throughout the procedure',
        attachments: ['vaccination_record.pdf'],
      ),
      AppointmentHistoryModel(
        appointmentId: 'APT105',
        patientId: 'PAT001',
        doctorId: 'DOC005',
        doctorName: 'Dr. Mohamed Khaled',
        specialty: 'Emergency Medicine',
        appointmentDate: now.subtract(const Duration(days: 45)),
        startTime: '16:00',
        endTime: '17:00',
        visitType: VisitType.emergency,
        price: 300.0,
        notes: 'Emergency visit for severe headache and dizziness',
        diagnosis: 'Migraine episode, dehydration',
        prescription: 'Pain medication, IV fluids administered',
        followUpInstructions:
            'Rest for 24 hours, increase fluid intake, follow-up if symptoms persist',
        completedAt: now.subtract(const Duration(days: 45)),
        rating: 4,
        patientFeedback: 'Quick response and effective treatment',
        attachments: ['emergency_report.pdf'],
      ),
    ];
  }

  List<AppointmentHistoryModel> get _filteredAppointments {
    if (_selectedFilter == 'all') {
      return _appointments;
    }

    final filterType = VisitType.values.firstWhere(
      (type) => type.toString().split('.').last == _selectedFilter,
      orElse: () => VisitType.consultation,
    );

    return _appointments.where((apt) => apt.visitType == filterType).toList();
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
        'appointment.history.title'.tr(),
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
            Icons.filter_list,
            color: ColorManager.primary,
          ),
          onPressed: _showFilterDialog,
        ),
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
            'appointment.loadingHistory'.tr(),
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
              Icons.history,
              size: 64.sp,
              color: ColorManager.textSecondary,
            ),
            SizedBox(height: 16.h),
            Text(
              'appointment.noHistory'.tr(),
              style: TextStyleManager.getSemiBoldStyle(
                fontSize: FontSize.s18,
                color: ColorManager.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              'appointment.noHistoryDescription'.tr(),
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
    final filteredAppointments = _filteredAppointments;

    return Column(
      children: [
        if (_selectedFilter != 'all') _buildActiveFilter(),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _loadAppointments,
            color: ColorManager.primary,
            child: ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: filteredAppointments.length,
              itemBuilder: (context, index) {
                final appointment = filteredAppointments[index];
                return AppointmentCard.fromHistory(
                  appointment: appointment,
                  onTap: () => _showAppointmentDetails(appointment),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActiveFilter() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      color: ColorManager.primary.withOpacity(0.1),
      child: Row(
        children: [
          Icon(
            Icons.filter_list,
            color: ColorManager.primary,
            size: 16.sp,
          ),
          SizedBox(width: 8.w),
          Text(
            'appointment.filteredBy'.tr(),
            style: TextStyleManager.getRegularStyle(
              fontSize: FontSize.s14,
              color: ColorManager.textSecondary,
            ),
          ),
          SizedBox(width: 4.w),
          Text(
            'appointment.visitType.$_selectedFilter'.tr(),
            style: TextStyleManager.getMediumStyle(
              fontSize: FontSize.s14,
              color: ColorManager.primary,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              setState(() {
                _selectedFilter = 'all';
              });
            },
            child: Text(
              'appointment.clearFilter'.tr(),
              style: TextStyleManager.getMediumStyle(
                fontSize: FontSize.s12,
                color: ColorManager.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'appointment.filterByVisitType'.tr(),
          style: TextStyleManager.getSemiBoldStyle(
            fontSize: FontSize.s16,
            color: ColorManager.textPrimary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _filterOptions.map((option) {
            return RadioListTile<String>(
              title: Text(
                option == 'all'
                    ? 'appointment.allTypes'.tr()
                    : 'appointment.visitType.$option'.tr(),
                style: TextStyleManager.getRegularStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.textPrimary,
                ),
              ),
              value: option,
              groupValue: _selectedFilter,
              onChanged: (value) {
                setState(() {
                  _selectedFilter = value!;
                });
                Navigator.of(context).pop();
              },
              activeColor: ColorManager.primary,
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'common.cancel'.tr(),
              style: TextStyleManager.getMediumStyle(
                fontSize: FontSize.s14,
                color: ColorManager.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAppointmentDetails(AppointmentHistoryModel appointment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildAppointmentDetailsSheet(appointment),
    );
  }

  Widget _buildAppointmentDetailsSheet(AppointmentHistoryModel appointment) {
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
                    'appointment.visitDetails'.tr(),
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
                  AppointmentCard.fromHistory(
                    appointment: appointment,
                  ),
                  SizedBox(height: 20.h),
                  _buildDetailSection(
                    'appointment.basicInfo'.tr(),
                    [
                      _buildDetailItem(
                        'appointment.appointmentId'.tr(),
                        appointment.appointmentId,
                      ),
                      _buildDetailItem(
                        'appointment.completedAt'.tr(),
                        appointment.formattedCompletedAt,
                      ),
                    ],
                  ),
                  if (appointment.diagnosis != null &&
                      appointment.diagnosis!.isNotEmpty)
                    _buildDetailSection(
                      'appointment.diagnosis'.tr(),
                      [
                        _buildDetailItem(
                          'appointment.diagnosis'.tr(),
                          appointment.diagnosis!,
                        ),
                      ],
                    ),
                  if (appointment.prescription != null &&
                      appointment.prescription!.isNotEmpty)
                    _buildDetailSection(
                      'appointment.prescription'.tr(),
                      [
                        _buildDetailItem(
                          'appointment.prescription'.tr(),
                          appointment.prescription!,
                        ),
                      ],
                    ),
                  if (appointment.followUpInstructions != null &&
                      appointment.followUpInstructions!.isNotEmpty)
                    _buildDetailSection(
                      'appointment.followUpInstructions'.tr(),
                      [
                        _buildDetailItem(
                          'appointment.followUpInstructions'.tr(),
                          appointment.followUpInstructions!,
                        ),
                      ],
                    ),
                  if (appointment.patientFeedback != null &&
                      appointment.patientFeedback!.isNotEmpty)
                    _buildDetailSection(
                      'appointment.patientFeedback'.tr(),
                      [
                        _buildDetailItem(
                          'appointment.patientFeedback'.tr(),
                          appointment.patientFeedback!,
                        ),
                      ],
                    ),
                  if (appointment.attachments != null &&
                      appointment.attachments!.isNotEmpty)
                    _buildDetailSection(
                      'appointment.attachments'.tr(),
                      [
                        _buildAttachmentsList(appointment.attachments!),
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

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyleManager.getSemiBoldStyle(
              fontSize: FontSize.s16,
              color: ColorManager.textPrimary,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: ColorManager.backgroundSecondary,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
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

  Widget _buildAttachmentsList(List<String> attachments) {
    return Column(
      children: attachments.map((attachment) {
        return Container(
          margin: EdgeInsets.only(bottom: 8.h),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: ColorManager.surface,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: ColorManager.border,
              width: 1.w,
            ),
          ),
          child: Row(
            children: [
              Icon(
                _getFileIcon(attachment),
                color: ColorManager.primary,
                size: 20.sp,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  attachment,
                  style: TextStyleManager.getRegularStyle(
                    fontSize: FontSize.s14,
                    color: ColorManager.textPrimary,
                  ),
                ),
              ),
              Icon(
                Icons.download,
                color: ColorManager.textSecondary,
                size: 20.sp,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  IconData _getFileIcon(String filename) {
    final extension = filename.split('.').last.toLowerCase();
    switch (extension) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icons.image;
      case 'doc':
      case 'docx':
        return Icons.description;
      default:
        return Icons.attach_file;
    }
  }
}

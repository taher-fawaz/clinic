import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/res/app_res.dart';
import '../../../../widgets/leading_back_button_widget.dart';
import '../../data/models/available_slot_model.dart';
import '../../data/models/book_appointment_request_model.dart';
import '../../data/models/book_appointment_response_model.dart';

import '../widgets/date_selector.dart';
import '../widgets/time_slot_list.dart';
import '../widgets/book_button.dart';
import '../widgets/appointment_card.dart';

class BookAppointmentScreen extends StatefulWidget {
  final String? doctorId;
  final String? specialty;

  const BookAppointmentScreen({
    super.key,
    this.doctorId,
    this.specialty,
  });

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  // Book Appointment Variables
  DateTime? _selectedDate;
  AvailableSlotModel? _selectedSlot;
  List<AvailableSlotModel> _availableSlots = [];
  bool _isLoadingSlots = false;
  bool _isBooking = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Initialize with today's date
    _selectedDate = DateTime.now();
    _loadAvailableSlots(_selectedDate!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundPrimary,
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: BookButton(
        selectedSlot: _selectedSlot,
        selectedDate: _selectedDate,
        onPressed: _bookAppointment,
        isLoading: _isBooking,
        isEnabled: !_isLoadingSlots,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: ColorManager.backgroundPrimary,
      elevation: 0,
      leading: const AppBackButton(),
      title: Text(
        'appointment.bookAppointment'.tr(),
        style: TextStyleManager.getSemiBoldStyle(
          fontSize: FontSize.s20,
          color: ColorManager.textPrimary,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepIndicator(),
          SizedBox(height: 24.h),
          DateSelector(
            selectedDate: _selectedDate,
            onDateSelected: _onDateSelected,
            minDate: DateTime.now(),
            maxDate: DateTime.now().add(const Duration(days: 90)),
          ),
          SizedBox(height: 24.h),
          TimeSlotList(
            timeSlots: _availableSlots,
            selectedSlot: _selectedSlot,
            onSlotSelected: _onSlotSelected,
            isLoading: _isLoadingSlots,
            errorMessage: _errorMessage,
          ),
          SizedBox(height: 100.h), // Space for bottom button
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
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
      child: Row(
        children: [
          _buildStep(
            stepNumber: 1,
            title: 'appointment.selectDate'.tr(),
            isCompleted: _selectedDate != null,
            isActive: _selectedDate == null,
          ),
          Expanded(
            child: Container(
              height: 2.h,
              color: _selectedDate != null
                  ? ColorManager.primary
                  : ColorManager.border,
            ),
          ),
          _buildStep(
            stepNumber: 2,
            title: 'appointment.selectTime'.tr(),
            isCompleted: _selectedSlot != null,
            isActive: _selectedDate != null && _selectedSlot == null,
          ),
          Expanded(
            child: Container(
              height: 2.h,
              color: _selectedSlot != null
                  ? ColorManager.primary
                  : ColorManager.border,
            ),
          ),
          _buildStep(
            stepNumber: 3,
            title: 'appointment.confirm'.tr(),
            isCompleted: false,
            isActive: _selectedSlot != null,
          ),
        ],
      ),
    );
  }

  Widget _buildStep({
    required int stepNumber,
    required String title,
    required bool isCompleted,
    required bool isActive,
  }) {
    return Flexible(
      child: Column(
        children: [
          Container(
            width: 32.w,
            height: 32.h,
            decoration: BoxDecoration(
              color: isCompleted
                  ? ColorManager.success
                  : isActive
                      ? ColorManager.primary
                      : ColorManager.surfaceVariant,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: isCompleted
                  ? Icon(
                      Icons.check,
                      size: 16.sp,
                      color: ColorManager.onSuccess,
                    )
                  : Text(
                      stepNumber.toString(),
                      style: TextStyleManager.getSemiBoldStyle(
                        fontSize: FontSize.s14,
                        color: isActive
                            ? ColorManager.onPrimary
                            : ColorManager.textTertiary,
                      ),
                    ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyleManager.getRegularStyle(
              fontSize: FontSize.s10,
              color: isCompleted || isActive
                  ? ColorManager.textPrimary
                  : ColorManager.textTertiary,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
      _selectedSlot = null; // Reset selected slot when date changes
    });
    _loadAvailableSlots(date);
  }

  void _onSlotSelected(AvailableSlotModel slot) {
    setState(() {
      _selectedSlot = slot;
    });
  }

  Future<void> _loadAvailableSlots(DateTime date) async {
    setState(() {
      _isLoadingSlots = true;
      _errorMessage = null;
      _availableSlots = [];
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock data - replace with actual API call
      final mockSlots = _generateMockSlots(date);

      setState(() {
        _availableSlots = mockSlots;
        _isLoadingSlots = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'appointment.errorLoadingSlots'.tr();
        _isLoadingSlots = false;
      });
    }
  }

  List<AvailableSlotModel> _generateMockSlots(DateTime date) {
    // Generate mock slots for single doctor clinic
    final slots = <AvailableSlotModel>[];
    final random = DateTime.now().millisecond;

    // Morning slots (9:00 AM - 1:00 PM)
    for (int i = 9; i <= 12; i++) {
      slots.add(AvailableSlotModel(
        id: 'slot_${date.day}_${i}_1',
        date: date,
        startTime: '${i.toString().padLeft(2, '0')}:00',
        endTime: '${i.toString().padLeft(2, '0')}:30',
        isAvailable: (random + i) % 4 != 0, // Most slots available
        doctorId: 'doc_1',
        doctorName: 'د. أحمد محمد',
        specialty: 'طب الأسنان العام',
        price: 200,
        durationMinutes: 30,
      ));

      slots.add(AvailableSlotModel(
        id: 'slot_${date.day}_${i}_2',
        date: date,
        startTime: '${i.toString().padLeft(2, '0')}:30',
        endTime: '${(i + 1).toString().padLeft(2, '0')}:00',
        isAvailable: (random + i + 1) % 5 != 0, // Most slots available
        doctorId: 'doc_1',
        doctorName: 'د. أحمد محمد',
        specialty: 'طب الأسنان العام',
        price: 200,
        durationMinutes: 30,
      ));
    }

    // Evening slots (4:00 PM - 8:00 PM)
    for (int i = 16; i <= 19; i++) {
      slots.add(AvailableSlotModel(
        id: 'slot_${date.day}_${i}_1',
        date: date,
        startTime: '${i.toString().padLeft(2, '0')}:00',
        endTime: '${i.toString().padLeft(2, '0')}:30',
        isAvailable: (random + i) % 4 != 0, // Most slots available
        doctorId: 'doc_1',
        doctorName: 'د. أحمد محمد',
        specialty: 'طب الأسنان العام',
        price: 200,
        durationMinutes: 30,
      ));

      slots.add(AvailableSlotModel(
        id: 'slot_${date.day}_${i}_2',
        date: date,
        startTime: '${i.toString().padLeft(2, '0')}:30',
        endTime: '${(i + 1).toString().padLeft(2, '0')}:00',
        isAvailable: (random + i + 1) % 5 != 0, // Most slots available
        doctorId: 'doc_1',
        doctorName: 'د. أحمد محمد',
        specialty: 'طب الأسنان العام',
        price: 200,
        durationMinutes: 30,
      ));
    }

    return slots;
  }

  Future<void> _bookAppointment() async {
    if (_selectedSlot == null || _selectedDate == null) return;

    setState(() {
      _isBooking = true;
    });

    try {
      // Create booking request
      final request = BookAppointmentRequestModel(
        slotId: _selectedSlot!.id,
        patientId: 'patient_123', // Replace with actual patient ID
        doctorId: _selectedSlot!.doctorId,
        appointmentDate: _selectedDate!,
        startTime: _selectedSlot!.startTime,
        endTime: _selectedSlot!.endTime,
        appointmentType: 'consultation',
        notes: null,
      );

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Mock successful response
      final response = BookAppointmentResponseModel(
        appointmentId: 'apt_${DateTime.now().millisecondsSinceEpoch}',
        status: 'confirmed',
        message: 'appointment.bookingConfirmed'.tr(),
        bookedAt: DateTime.now(),
        appointmentDetails: AppointmentDetailsModel(
          slotId: _selectedSlot!.id,
          doctorId: _selectedSlot!.doctorId,
          doctorName: _selectedSlot!.doctorName,
          specialty: _selectedSlot!.specialty,
          appointmentDate: _selectedDate!,
          startTime: _selectedSlot!.startTime,
          endTime: _selectedSlot!.endTime,
          price: _selectedSlot!.price,
          appointmentType: 'consultation',
        ),
      );

      setState(() {
        _isBooking = false;
      });

      // Show success dialog
      _showBookingSuccessDialog(response);
    } catch (e) {
      setState(() {
        _isBooking = false;
      });

      // Show error dialog
      _showErrorDialog('appointment.bookingFailed'.tr());
    }
  }

  void _showBookingSuccessDialog(BookAppointmentResponseModel response) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: ColorManager.success,
              size: 24.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'appointment.bookingConfirmed'.tr(),
              style: TextStyleManager.getSemiBoldStyle(
                fontSize: FontSize.s18,
                color: ColorManager.textPrimary,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'appointment.appointmentId'.tr(),
              style: TextStyleManager.getRegularStyle(
                fontSize: FontSize.s14,
                color: ColorManager.textSecondary,
              ),
            ),
            Text(
              response.appointmentId,
              style: TextStyleManager.getSemiBoldStyle(
                fontSize: FontSize.s16,
                color: ColorManager.primary,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              response.message,
              style: TextStyleManager.getRegularStyle(
                fontSize: FontSize.s14,
                color: ColorManager.textPrimary,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              // Check if we can pop safely
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop(); // Go back to previous screen
              }
            },
            child: Text(
              'common.ok'.tr(),
              style: TextStyleManager.getSemiBoldStyle(
                fontSize: FontSize.s16,
                color: ColorManager.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            Icon(
              Icons.error,
              color: ColorManager.error,
              size: 24.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'common.error'.tr(),
              style: TextStyleManager.getSemiBoldStyle(
                fontSize: FontSize.s18,
                color: ColorManager.textPrimary,
              ),
            ),
          ],
        ),
        content: Text(
          message,
          style: TextStyleManager.getRegularStyle(
            fontSize: FontSize.s14,
            color: ColorManager.textPrimary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'common.ok'.tr(),
              style: TextStyleManager.getSemiBoldStyle(
                fontSize: FontSize.s16,
                color: ColorManager.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

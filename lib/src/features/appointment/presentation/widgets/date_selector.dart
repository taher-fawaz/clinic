import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';
import '../../../../core/res/app_res.dart';

class DateSelector extends StatefulWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;
  final DateTime? minDate;
  final DateTime? maxDate;
  final List<DateTime>? disabledDates;

  const DateSelector({
    super.key,
    this.selectedDate,
    required this.onDateSelected,
    this.minDate,
    this.maxDate,
    this.disabledDates,
  });

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  late PageController _pageController;
  late DateTime _currentMonth;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime.now();
    _selectedDate = widget.selectedDate;
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
          _buildCalendar(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'appointment.selectDate'.tr(),
          style: TextStyleManager.getSemiBoldStyle(
            fontSize: FontSize.s18,
            color: ColorManager.textPrimary,
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: _previousMonth,
              icon: Icon(
                Icons.chevron_left,
                color: ColorManager.primary,
                size: 24.sp,
              ),
            ),
            Text(
              DateFormat('MMMM yyyy', context.locale.languageCode)
                  .format(_currentMonth),
              style: TextStyleManager.getMediumStyle(
                fontSize: FontSize.s16,
                color: ColorManager.textPrimary,
              ),
            ),
            IconButton(
              onPressed: _nextMonth,
              icon: Icon(
                Icons.chevron_right,
                color: ColorManager.primary,
                size: 24.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCalendar() {
    return Column(
      children: [
        _buildWeekDaysHeader(),
        SizedBox(height: 8.h),
        _buildDaysGrid(),
      ],
    );
  }

  Widget _buildWeekDaysHeader() {
    final weekDays = [
      'calendar.sun'.tr(),
      'calendar.mon'.tr(),
      'calendar.tue'.tr(),
      'calendar.wed'.tr(),
      'calendar.thu'.tr(),
      'calendar.fri'.tr(),
      'calendar.sat'.tr(),
    ];

    return Row(
      children: weekDays.map((day) {
        return Expanded(
          child: Center(
            child: Text(
              day,
              style: TextStyleManager.getMediumStyle(
                fontSize: FontSize.s12,
                color: ColorManager.textSecondary,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDaysGrid() {
    final daysInMonth = _getDaysInMonth(_currentMonth);
    final firstDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final startingWeekday = firstDayOfMonth.weekday % 7;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1,
      ),
      itemCount: 42, // 6 weeks * 7 days
      itemBuilder: (context, index) {
        final dayIndex = index - startingWeekday + 1;
        
        if (dayIndex < 1 || dayIndex > daysInMonth) {
          return const SizedBox();
        }

        final date = DateTime(_currentMonth.year, _currentMonth.month, dayIndex);
        final isSelected = _selectedDate != null &&
            _selectedDate!.year == date.year &&
            _selectedDate!.month == date.month &&
            _selectedDate!.day == date.day;
        final isToday = _isToday(date);
        final isDisabled = _isDateDisabled(date);

        return GestureDetector(
          onTap: isDisabled ? null : () => _selectDate(date),
          child: Container(
            margin: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: isSelected
                  ? ColorManager.primary
                  : isToday
                      ? ColorManager.primaryLight.withOpacity(0.2)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(8.r),
              border: isToday && !isSelected
                  ? Border.all(color: ColorManager.primary, width: 1)
                  : null,
            ),
            child: Center(
              child: Text(
                dayIndex.toString(),
                style: TextStyleManager.getMediumStyle(
                  fontSize: FontSize.s14,
                  color: isDisabled
                      ? ColorManager.textTertiary
                      : isSelected
                          ? ColorManager.onPrimary
                          : isToday
                              ? ColorManager.primary
                              : ColorManager.textPrimary,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    widget.onDateSelected(date);
  }

  bool _isToday(DateTime date) {
    final today = DateTime.now();
    return date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;
  }

  bool _isDateDisabled(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    // Disable past dates
    if (date.isBefore(today)) return true;
    
    // Check min/max dates
    if (widget.minDate != null && date.isBefore(widget.minDate!)) return true;
    if (widget.maxDate != null && date.isAfter(widget.maxDate!)) return true;
    
    // Check disabled dates list
    if (widget.disabledDates != null) {
      return widget.disabledDates!.any((disabledDate) =>
          date.year == disabledDate.year &&
          date.month == disabledDate.month &&
          date.day == disabledDate.day);
    }
    
    return false;
  }

  int _getDaysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }
}
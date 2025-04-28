import 'package:clinic/core/utils/app_colors.dart';
import 'package:clinic/core/utils/app_text_styles.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../cubits/booking_cubit.dart';
import '../../widgets/getTimeWidget.dart';

class StepOne extends StatefulWidget {
  @override
  State<StepOne> createState() => _StepOneState();
}

class _StepOneState extends State<StepOne> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        reverse: true,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                children: [
                  dateWidget(),
                   GetTimeWidget(),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            )));
  }

  Widget dateWidget() {
    return EasyDateTimeLine(
      locale: "ar",
      initialDate: context.read<BookingCubit>().selectedDate,
      activeColor: AppColors.primaryColor,
        disabledDates: List.generate(
          DateTime.now().difference(DateTime(1900)).inDays,
              (index) => DateTime(1900).add(Duration(days: index)),
        ),
      headerProps: EasyHeaderProps(
        monthStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.lightSecondaryColor),

      ),

      dayProps: EasyDayProps(
        todayStyle: DayStyle(
            decoration: BoxDecoration(
              color: Colors.blueGrey.withAlpha(20),
              borderRadius: BorderRadius.circular(10),
            ),
            dayNumStyle: TextStyles.semiBold13),
      ),
        onDateChange: (value) {
        context.read<BookingCubit>().selectedDate = value ;
        context.read<BookingCubit>().fetchTodayTasks(context, context.read<BookingCubit>().selectedDate);
}
    );
  }

}

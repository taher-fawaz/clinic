import 'package:clinic/features/booking/views/widgets/bookingViewBody.dart';
import 'package:flutter/material.dart';
import 'package:time_slot/time_slot.dart';

import '../../core/widgets/custom_app_bar.dart';

class BookingView extends StatelessWidget {
  const BookingView({super.key});
  static const String routeName = 'bookingView';
  @override
  Widget build(BuildContext context) {
    final String title;
    DayPartController dayPartController = DayPartController();
    List<DateTime> selectTime = [];
    return Scaffold(
      appBar: buildAppBar(context, title: "حجز الموعد"),
      body: SafeArea(child: BookingViewBody()),
    );
  }
}

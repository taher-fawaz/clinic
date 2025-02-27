import 'package:clinic/features/booking/views/widgets/stepper/stepperView.dart';
import 'package:flutter/material.dart';

import '../../core/widgets/custom_app_bar.dart';

class BookingView extends StatelessWidget {
  const BookingView({super.key});
  static const String routeName = 'bookingView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: "حجز الموعد", showBackButton: false),
      body: SafeArea(
        child: CustomStepper(),
      ),
    );
  }
}

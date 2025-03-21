import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper_functions/build_error_bar.dart';
import '../../../../../core/widgets/custom_progress_hud.dart';
import '../../cubits/booking_cubit.dart';
import '../../../../actionConfirm/actionConfirm.dart';
import '../stepper/stepperView.dart';

class BookingViewBodyBlocconsumer extends StatefulWidget {
  const BookingViewBodyBlocconsumer({super.key});

  @override
  State<BookingViewBodyBlocconsumer> createState() =>
      _BookingViewBodyBlocconsumerState();
}

class _BookingViewBodyBlocconsumerState
    extends State<BookingViewBodyBlocconsumer> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingCubit, BookingState>(
      listener: (context, state) {
        if (state is BookingSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ActionConfirm()),
          );
        }

        if (state is BookingFailure) {
          showBar(context, state.message);
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is BookingLoading ? true : false,
          child: const CustomStepper(),
        );
      },
    );
  }
}

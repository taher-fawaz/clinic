import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper_functions/build_error_bar.dart';
import '../../../../../core/widgets/custom_progress_hud.dart';
import '../../../../actionConfirm/presentation/view/actionConfirm_view.dart';
import '../../cubits/booking_cubit.dart';
import '../stepper/stepperView.dart';

class BookingViewBodyBlocConsumer extends StatefulWidget {
  const BookingViewBodyBlocConsumer({super.key});

  @override
  State<BookingViewBodyBlocConsumer> createState() =>
      _BookingViewBodyBlocConsumerState();
}

class _BookingViewBodyBlocConsumerState
    extends State<BookingViewBodyBlocConsumer> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingCubit, BookingState>(
      listener: (context, state) {
        if (state is BookingSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ActionConfirm()),
          );
          showBar(context, "تم حجز الموعد بنجاح");
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

import 'package:clinic/features/booking/presentation/views/widgets/stepper/stepperView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper_functions/build_error_bar.dart';
import '../../../../../core/widgets/custom_progress_hud.dart';
import '../../cubits/booking_cubit.dart';
import '../actionConfirm.dart';

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
          Navigator.pushNamed(context, ActionConfirm.routeName);
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

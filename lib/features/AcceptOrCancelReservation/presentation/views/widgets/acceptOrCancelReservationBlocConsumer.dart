import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper_functions/build_error_bar.dart';
import '../../../../../core/widgets/custom_progress_hud.dart';
import '../../cuibts/accept_or_cancel_reservation_cubit.dart';
import 'acceptOrCancelReservationBody.dart';

class AcceptOrCancelReservationBlocConsumer extends StatefulWidget {
  const AcceptOrCancelReservationBlocConsumer({super.key});

  @override
  State<AcceptOrCancelReservationBlocConsumer> createState() => _AcceptOrCancelReservationBlocConsumerState();
}

class _AcceptOrCancelReservationBlocConsumerState extends State<AcceptOrCancelReservationBlocConsumer> {
  @override
  void initState() {
    context.read<AcceptOrCancelReservationCubit>().acceptOrCancelReservation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AcceptOrCancelReservationCubit, AcceptOrCancelReservationState>(
      listener: (context, state) {
        if (state is AcceptOrCancelReservationFailure) {
          showBar(context, state.message);
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is AcceptOrCancelReservationLoading,
          child: state is AcceptOrCancelReservationSuccess
              ? AcceptOrCancelReservationBody(patients: state.patients)
              : Container(), // Provide a default widget when not loading or successful
        );
      },
    );
  }
}
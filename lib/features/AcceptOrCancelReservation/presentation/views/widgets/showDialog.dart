import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper_functions/build_error_bar.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_progress_hud.dart';
import '../../cuibts/accept_or_cancel_reservation_cubit.dart';

class AcceptOrDeleteBookingBody extends StatefulWidget {
  String userId;

  AcceptOrDeleteBookingBody({super.key, required this.userId});

  @override
  State<AcceptOrDeleteBookingBody> createState() =>
      _AcceptOrDeleteBookingBodyState();
}

class _AcceptOrDeleteBookingBodyState extends State<AcceptOrDeleteBookingBody> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("تاكيد الموافقه"),
      actions: [Row(children: [
        Row(
          children: [
            CustomButton(onPressed: () {
              context.read<AcceptOrCancelReservationCubit>()
                  .deletePatientDocument(widget.userId);
              context.read<AcceptOrCancelReservationCubit>().acceptOrCancelReservationAction(true, context,widget.userId);

            }, text: "موافقة ", width: 100,),
            SizedBox(width: 30,),
            CustomButton(onPressed: () {
              context.read<AcceptOrCancelReservationCubit>()
                  .deletePatientDocument(widget.userId);
              context.read<AcceptOrCancelReservationCubit>().acceptOrCancelReservationAction(false,context,widget.userId);
            }, text: "رفض ", width: 100),
          ],)
      ],)
      ],
    );;
  }
}

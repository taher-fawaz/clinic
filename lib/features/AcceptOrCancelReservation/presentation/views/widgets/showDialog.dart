import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../cuibts/accept_or_cancel_reservation_cubit.dart';

class AcceptOrDeleteBookingBody extends StatefulWidget {
  final String userId;

  AcceptOrDeleteBookingBody({super.key, required this.userId});

  @override
  State<AcceptOrDeleteBookingBody> createState() =>
      _AcceptOrDeleteBookingBodyState();
}

class _AcceptOrDeleteBookingBodyState extends State<AcceptOrDeleteBookingBody> {
  late final AcceptOrCancelReservationCubit myProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    myProvider = context.read<AcceptOrCancelReservationCubit>();
     // myProvider.acceptOrCancelReservationAction(true, context, widget.userId);
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("تاكيد الموافقه"),
      actions: [
        Row(
          children: [
            CustomButton(
              onPressed: () {
                myProvider.deletePatientDocument(widget.userId);
                myProvider.acceptOrCancelReservationAction(true, context, widget.userId);

              },
              text: "موافقة ",
              width: 100,
            ),
            SizedBox(width: 30),
            CustomButton(
              onPressed: () {
                myProvider.deletePatientDocument(widget.userId);
                myProvider.acceptOrCancelReservationAction(false, context, widget.userId);
              },
              text: "رفض ",
              width: 100,
            ),
          ],
        ),
      ],
    );
  }
}
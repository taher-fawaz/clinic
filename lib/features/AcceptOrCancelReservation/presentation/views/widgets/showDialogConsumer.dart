import 'package:clinic/features/AcceptOrCancelReservation/presentation/views/widgets/showDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helper_functions/build_error_bar.dart';
import '../../../../../core/widgets/custom_progress_hud.dart';
import '../../cuibts/accept_or_cancel_reservation_cubit.dart';

class ShowDialogConsumer extends StatefulWidget {
  String userId;
  ShowDialogConsumer({super.key, required this.userId});
  @override
  State<ShowDialogConsumer> createState() => _ShowDialogConsumerState();
}

class _ShowDialogConsumerState extends State<ShowDialogConsumer> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AcceptOrCancelReservationCubit, AcceptOrCancelReservationState>(
      listener: (context, state) {
        if (state is DeletedPatientSuccess) {
          if (mounted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                Navigator.of(context).pop();
                showBar(context, "تمت العملية بنجاح");
              }
            });
          }
        }

        if (state is DeletedPatientFailure) {
          if (mounted) {
            showBar(context, "حدث خطا");

        }}
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is DeletedPatientLoading ? true : false,
          child:  AcceptOrDeleteBookingBody(userId: widget.userId,),
        );
      },
    );


  }
}

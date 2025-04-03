import 'package:clinic/features/AcceptOrCancelReservation/presentation/views/widgets/acceptOrCancelReservationBlocConsumer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/get_it_service.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../data/repo.dart';
import '../cuibts/accept_or_cancel_reservation_cubit.dart';

class AcceptOrCancelReservation extends StatelessWidget {
  const AcceptOrCancelReservation({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      appBar: CustomBuildAppBar(context,
          title: "جميع الكشوفات ", showBackButton: false),

      body: BlocProvider(
          create: (context) => AcceptOrCancelReservationCubit(
      getIt.get<FirebaseAcceptOrCancelReservationRepo>(),
    ),
    child:
    AcceptOrCancelReservationBlocConsumer(),
      )
    );
  }
}

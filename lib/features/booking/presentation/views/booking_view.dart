import 'package:clinic/core/widgets/custom_app_bar.dart';
import 'package:clinic/features/booking/presentation/views/widgets/booking_view_body_blocConsumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/get_it_service.dart';
import '../../data/repos/repo.dart';
import '../cubits/booking_cubit.dart';

class BookingView extends StatelessWidget {
  const BookingView({super.key});
  static const String routeName = 'bookingView';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => BookingCubit(
              getIt.get<FirebaseBookingRepo>(),
            ),
        child: Scaffold(
          appBar: CustomBuildAppBar(context,
              title: "حجز الموعد", showBackButton: false),
          body: SafeArea(child: BookingViewBodyBlocConsumer()

              ),
        ));
  }
}

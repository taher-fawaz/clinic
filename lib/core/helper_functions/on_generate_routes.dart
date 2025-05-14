import 'package:clinic/core/services/get_it_service.dart';
import 'package:clinic/features/auth/presentation/views/signin_view.dart';
import 'package:clinic/features/auth/presentation/views/signup_view.dart';
import 'package:clinic/features/main_view/presentation/pages/main_view.dart';
import 'package:clinic/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:clinic/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/appointment/presentation/bloc/appointment_bloc.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => const SplashView());
    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (context) => const OnBoardingView());

    case SigninView.routeName:
      return MaterialPageRoute(builder: (context) => const SigninView());
    case SignupView.routeName:
      return MaterialPageRoute(builder: (context) => const SignupView());
    case MainView.routeName:
      return MaterialPageRoute(
          builder: (context) => BlocProvider<AppointmentBloc>(
                create: (context) => AppointmentBloc(appointmentRepo: getIt()),
                child: const MainView(),
              ));

    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}

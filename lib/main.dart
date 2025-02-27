import 'package:clinic/core/helper_functions/on_generate_routes.dart';
import 'package:clinic/core/services/custom_bloc_observer.dart';
import 'package:clinic/core/services/get_it_service.dart';
import 'package:clinic/core/services/shared_preferences_singleton.dart';
import 'package:clinic/core/utils/app_colors.dart';
import 'package:clinic/features/splash/presentation/views/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initializeDateFormatting('ar', '').then((value) => null);
  initializeDateFormatting('en', '').then((value) => null);
  await Firebase.initializeApp();
  Bloc.observer = CustomBlocObserver();

  await Prefs.init();

  setupGetit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Cairo',
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
        ),
      ),
      onGenerateRoute: onGenerateRoute,
      initialRoute: SplashView.routeName,
      debugShowCheckedModeBanner: false,
    );
  }
}

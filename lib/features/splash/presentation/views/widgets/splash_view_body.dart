import 'package:clinic/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:flutter/material.dart';
import 'package:clinic/constants.dart';
import 'package:clinic/core/services/firebase_auth_service.dart';
import 'package:clinic/core/utils/app_images.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/services/shared_preferences_singleton.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    excuteNaviagtion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(Assets.imagesLogo),
      ],
    );
  }

  void excuteNaviagtion() {
    // bool isOnBoardingViewSeen = Prefs.getBool(kIsOnBoardingViewSeen);
    Future.delayed(const Duration(seconds: 3), () {
      // if (isOnBoardingViewSeen) {
      //   var isLoggedIn = FirebaseAuthService().isLoggedIn();

      //   if (isLoggedIn) {
      //     Navigator.pushReplacementNamed(context, MainView.routeName);
      //   } else {
      //     Navigator.pushReplacementNamed(context, SigninView.routeName);
      //   }
      // } else {
      Navigator.pushReplacementNamed(context, OnBoardingView.routeName);
      // }
    });
  }
}

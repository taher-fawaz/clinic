import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'app_route_path.dart';
import 'routes.dart';

class AppRouteConf {
  GoRouter get router => _router;

  late final _router = GoRouter(
    initialLocation: AppRoute.splash.path,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoute.splash.path,
        name: AppRoute.splash.name,
        builder: (_, __) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoute.onboarding.path,
        name: AppRoute.onboarding.name,
        builder: (_, __) => const OnboardingPage(),
      ),
      GoRoute(
        path: AppRoute.login.path,
        name: AppRoute.login.name,
        builder: (_, __) => const PatientLoginPage(),
      ),
      GoRoute(
        path: AppRoute.register.path,
        name: AppRoute.register.name,
        builder: (_, __) => const PatientRegisterPage(),
      ),
      GoRoute(
        path: AppRoute.home.path,
        name: AppRoute.home.name,
        builder: (_, state) {
          final params = state.pathParameters;

          final user = UserEntity(
            username: params["username"],
            email: params["email"],
            userId: params["user_id"],
          );

          return const PatientHomeScreen();
        },
      ),
    ],
  );
}

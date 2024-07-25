import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Features/OnBoarding/presentation/Views/OnboardingView.dart';
import 'package:sintir/Features/Splash/presentation/Views/SplashView.dart';
import 'package:sintir/Features/Student/Student%20Auth/presentation/views/Student_Signin_View.dart';

class Approute {
  static const String SPLASH = '/';
  static const String Onboarding = '/Onboarding';
  static const String ChossingState = '/ChossingState';
  static const String StudentSignin = '/StudentSignin';

  static GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: SPLASH,
        builder: (BuildContext context, GoRouterState state) {
          return Directionality(
              textDirection: TextDirection.rtl, child: const Splashview());
        },
      ),
      GoRoute(
        path: Onboarding,
        builder: (BuildContext context, GoRouterState state) {
          return Directionality(
              textDirection: TextDirection.rtl, child: Onboardingview());
        },
      ),
      GoRoute(
        path: StudentSignin,
        builder: (BuildContext context, GoRouterState state) {
          return Directionality(
              textDirection: TextDirection.rtl, child: Student_Signin_View());
        },
      ),
    ],
  );
}

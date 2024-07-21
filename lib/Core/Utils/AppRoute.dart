import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Features/Splash/presentation/Views/SplashView.dart';

class Approute {
  static const String SPLASH = '/';
  static GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: SPLASH,
        builder: (BuildContext context, GoRouterState state) {
          return Directionality(
              textDirection: TextDirection.rtl, child: const Splashview());
        },
      ),
    ],
  );
}

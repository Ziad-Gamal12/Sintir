// ignore_for_file: file_names, camel_case_types
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Features/ChoosingState/Presentation/views/ChoosingStateView.dart';
import 'package:sintir/Features/Splash/Presentation/views/SplashView.dart';
import 'package:sintir/Features/StudentOnboarding/Presentation/Views/ResetPasswordPage.dart';
import 'package:sintir/Features/StudentOnboarding/Presentation/Views/StudentOnboardingView.dart';
import 'package:sintir/Features/TeaacherOnBoarding/Presentation/Views/TeacherOnboardingView.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/TeacherLoginView.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/TeacherSignUpView.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/teacherResetPasswordView.dart';

import '../../Features/StudentOnboarding/Presentation/Views/Student_login_screen.dart';

class App_router {
  static GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: Splashview.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const Splashview();
        },
      ),
      GoRoute(
        path: Choosingstateview.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const Choosingstateview();
        },
      ),
      GoRoute(
        path: TeacherOnboardingView.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const TeacherOnboardingView();
        },
      ),
      GoRoute(
        path: StudentOnboardingView.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const StudentOnboardingView();
        },
      ),
      GoRoute(
        path: TeacherSignUpView.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const TeacherSignUpView();
        },
      ),
      GoRoute(
        path: TeacherLoginView.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const TeacherLoginView();
        },
      ),
      GoRoute(
        path: StudentLoginPage.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const StudentLoginPage();
        },
      ),
      GoRoute(
        path: ResetPasswordPage.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const ResetPasswordPage();
        },
      ),
      ),
      GoRoute(
        path: teacherResetPasswordView.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const teacherResetPasswordView();
        },
      )
    ],
  );
}

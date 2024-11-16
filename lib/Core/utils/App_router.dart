// ignore_for_file: file_names, camel_case_types
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/widgets/customAuthWidgets/CustomResetPasswordView.dart';
import 'package:sintir/Features/ChoosingState/Presentation/views/ChoosingStateView.dart';
import 'package:sintir/Features/Home/presentation/views/HomeView.dart';
import 'package:sintir/Features/Splash/Presentation/views/SplashView.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/StudentTermsAndConditions_View.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/Student_Sign_In_View.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/Student_signUp_View.dart';
import 'package:sintir/Features/StudentOnboarding/Presentation/Views/StudentOnboardingView.dart';
import 'package:sintir/Features/TeaacherOnBoarding/Presentation/Views/TeacherOnboardingView.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/TeacherLoginView.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/TeacherSignUpView.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/teacherTermsAndConditionsView.dart';
import 'package:sintir/Features/tasks/presentation/views/todoListView.dart';

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
        path: CustomResetPasswordView.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const CustomResetPasswordView();
        },
      ),
      GoRoute(
        path: Teachertermsandconditionsview.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const Teachertermsandconditionsview();
        },
      ),
      GoRoute(
        path: StudentSignInView.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const StudentSignInView();
        },
      ),
      GoRoute(
        path: StudentSignupView.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const StudentSignupView();
        },
      ),
      GoRoute(
        path: StudenttermsandconditionsView.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const StudenttermsandconditionsView();
        },
      ),
      GoRoute(
        path: Homeview.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const Homeview();
        },
      ),
      GoRoute(
        path: Todolistview.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const Todolistview();
        },
      ),
    ],
  );
}

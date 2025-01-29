// ignore_for_file: file_names, camel_case_types
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/widgets/customAuthWidgets/CustomResetPasswordView.dart';
import 'package:sintir/Features/AI_Chat/presentation/views/aiChatView.dart';
import 'package:sintir/Features/Books_Library/Presentation/Views/EducationLevelsBooksSectionsView.dart';
import 'package:sintir/Features/Books_Library/Presentation/Views/LevelBooksView.dart';
import 'package:sintir/Features/ChoosingState/Presentation/views/ChoosingStateView.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursefedbackItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/DisplayVediRequiresEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/CourseFedBackView.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/CourseFilePreviewer_View.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/CourseIntroductionView.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/SendCourseReportView.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/courseTestView.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/displayCourseVedioVeiw.dart';
import 'package:sintir/Features/Favorites/presentation/views/FavoritesView.dart';
import 'package:sintir/Features/Home/presentation/views/HomeView.dart';
import 'package:sintir/Features/Splash/Presentation/views/SplashView.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/StudentTermsAndConditions_View.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/Student_Sign_In_View.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/Student_signUp_View.dart';
import 'package:sintir/Features/StudentOnboarding/Presentation/Views/StudentOnboardingView.dart';
import 'package:sintir/Features/StudentProfile/presentation/views/studentProfileView.dart';
import 'package:sintir/Features/TeaacherOnBoarding/Presentation/Views/TeacherOnboardingView.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/TeacherLoginView.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/TeacherSignUpView.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/teacherTermsAndConditionsView.dart';
import 'package:sintir/Features/TeacherProfile/presentation/views/TeacherProfileView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/AddCourseFirstContentView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/AddCourseView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/TeacherWorkenvironmentview.dart';
import 'package:sintir/Features/tasks/presentation/views/TasksView.dart';

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
        path: TasksView.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const TasksView();
        },
      ),
      GoRoute(
        path: Aichatview.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const Aichatview();
        },
      ),
      GoRoute(
        path: EducationLevelsBooksSectionsView.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const EducationLevelsBooksSectionsView();
        },
      ),
      GoRoute(
        path: Levelbooksview.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const Levelbooksview();
        },
      ),
      GoRoute(
        path: Favoritesview.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const Favoritesview();
        },
      ),
      GoRoute(
        path: CourseIntroductionView.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return CourseIntroductionView(
            course: state.extra as CourseEntity,
          );
        },
      ),
      GoRoute(
        path: Displaycoursevedioveiw.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return Displaycoursevedioveiw(
            displayVedioRequiresEntity:
                state.extra as Displayvedirequiresentity,
          );
        },
      ),
      GoRoute(
        path: Coursetestview.routename,
        builder: (BuildContext context, GoRouterState state) {
          return Coursetestview(
            coursetestentity: state.extra as Coursetestentity,
          );
        },
      ),
      GoRoute(
        path: Sendcoursereportview.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const Sendcoursereportview();
        },
      ),
      GoRoute(
        path: Coursefedbackview.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return Coursefedbackview(
            fedBacks: state.extra as List<CoursefedbackItemEntity>,
          );
        },
      ),
      GoRoute(
        path: CoursefilepreviewerView.routename,
        builder: (BuildContext context, GoRouterState state) {
          return CoursefilepreviewerView(
            coursefileentity: state.extra as Coursefileentity,
          );
        },
      ),
      GoRoute(
        path: Studentprofileview.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const Studentprofileview();
        },
      ),
      GoRoute(
        path: Teacherprofileview.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const Teacherprofileview();
        },
      ),
      GoRoute(
        path: TeacherWorkenvironmentview.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const TeacherWorkenvironmentview();
        },
      ),
      GoRoute(
        path: Addcourseview.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const Addcourseview();
        },
      ),
      GoRoute(
        path: Addcoursefirstcontentview.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const Addcoursefirstcontentview();
        },
      ),
    ],
  );
}

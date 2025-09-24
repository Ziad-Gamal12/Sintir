// ignore_for_file: file_names, camel_case_types
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestViewNavigationsRequirmentsEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVideoviewnavigationsrequirmentsentity.dart';
import 'package:sintir/Core/entities/PayMobWebViewRequirmentsEntity.dart';
import 'package:sintir/Core/widgets/WebViewer/WebView.dart';
import 'package:sintir/Core/widgets/customAuthWidgets/CustomResetPasswordView.dart';
import 'package:sintir/Features/Ai_Teacher/presentation/views/AiTeacherView.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/StudentTermsAndConditions_View.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/Student_Sign_In_View.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/Student_signUp_View.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/TeacherSignInView.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/TeacherSignUpView.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/teacherTermsAndConditionsView.dart';
import 'package:sintir/Features/ChoosingUserKind/Presentation/views/ChoosingUserKindView.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileviewnavigationsrequirmentsentity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/CourseFedBackView.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/CourseFilePreviewer_View.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/CourseIntroductionView.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/ReviewTestResultView.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/SendCourseReportView.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/courseTestView.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/displayCourseVedioVeiw.dart';
import 'package:sintir/Features/Favorites/presentation/views/FavoritesView.dart';
import 'package:sintir/Features/Home/presentation/views/HomeView.dart';
import 'package:sintir/Features/Splash/Presentation/views/SplashView.dart';
import 'package:sintir/Features/StudentOnboarding/Presentation/Views/StudentOnboardingView.dart';
import 'package:sintir/Features/StudentProfile/presentation/views/studentProfileView.dart';
import 'package:sintir/Features/Subscribtion/Presentation/View/SubscribtionView.dart';
import 'package:sintir/Features/TeaacherOnBoarding/Presentation/Views/TeacherOnboardingView.dart';
import 'package:sintir/Features/TeacherProfile/presentation/views/TeacherProfileView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/navigateSQlReviewRequirmentsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/AddCourseSectionFileView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/AddCourseSectionSQLView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/AddCourseSectionVedioView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/AddCourseSectionView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/AddCourseView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/CourseDetailView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/FileConsequencesView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/ReviewSqlTestSectionView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/TeacherWorkenvironmentview.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/TestConsequencesView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/VideoConsequencesView.dart';

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
        path: ChoosingUserKindView.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const ChoosingUserKindView();
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
        path: TeacherSignInView.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const TeacherSignInView();
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
        path: AiTeacherview.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const AiTeacherview();
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
            bottomsheetnavigationrequirmentsentity: state.extra
                as DisplayCourseBottomsheetNavigationRequirmentsEntity,
          );
        },
      ),
      GoRoute(
        path: Displaycoursevedioveiw.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return Displaycoursevedioveiw(
            coursevideoviewnavigationsrequirmentsentity:
                state.extra as Coursevideoviewnavigationsrequirmentsentity,
          );
        },
      ),
      GoRoute(
        path: Coursetestview.routename,
        builder: (BuildContext context, GoRouterState state) {
          return Coursetestview(
            coursetestviewnavigationsrequirmentsentity:
                state.extra as Coursetestviewnavigationsrequirmentsentity,
          );
        },
      ),
      GoRoute(
        path: Sendcoursereportview.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return Sendcoursereportview(
            requirmentsEntity: state.extra
                as DisplayCourseBottomsheetNavigationRequirmentsEntity,
          );
        },
      ),
      GoRoute(
        path: Coursefedbackview.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return Coursefedbackview(
            requirmentsEntity: state.extra
                as DisplayCourseBottomsheetNavigationRequirmentsEntity,
          );
        },
      ),
      GoRoute(
        path: CoursefilepreviewerView.routename,
        builder: (BuildContext context, GoRouterState state) {
          return CoursefilepreviewerView(
            coursefileviewnavigationsrequirmentsentity:
                state.extra as Coursefileviewnavigationsrequirmentsentity,
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
          return TeacherWorkenvironmentview(
            myCourses: state.extra as List<CourseEntity>,
          );
        },
      ),
      GoRoute(
        path: Addcourseview.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return const Addcourseview();
        },
      ),
      GoRoute(
        path: CourseDetailView.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return CourseDetailView(
            courseEntity: state.extra as CourseEntity,
          );
        },
      ),
      GoRoute(
        path: Addcoursesectionview.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return Addcoursesectionview(
            course: state.extra as CourseEntity,
          );
        },
      ),
      GoRoute(
        path: Addcoursesectionsqlview.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return Addcoursesectionsqlview(
            optionnavigationrequirementsentity:
                state.extra as Optionnavigationrequirementsentity,
          );
        },
      ),
      GoRoute(
        path: ReviewSqlTestSectionView.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return ReviewSqlTestSectionView(
            navigatesqlreviewrequirmentsentity:
                state.extra as Navigatesqlreviewrequirmentsentity,
          );
        },
      ),
      GoRoute(
        path: Addcoursesectionvedioview.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return Addcoursesectionvedioview(
            optionnavigationrequirementsentity:
                state.extra as Optionnavigationrequirementsentity,
          );
        },
      ),
      GoRoute(
        path: Addcoursesectionfileview.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return Addcoursesectionfileview(
            optionnavigationrequirementsentity:
                state.extra as Optionnavigationrequirementsentity,
          );
        },
      ),
      GoRoute(
        path: Webviewer.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return Webviewer(
            requirmentsEntity: state.extra as PayMobWebViewRequirmentsEntity,
          );
        },
      ),
      GoRoute(
        path: Reviewtestresultview.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return Reviewtestresultview(
            resultEntity: state.extra as TestresulteEntity,
          );
        },
      ),
      GoRoute(
        path: TestConsequencesView.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return TestConsequencesView(
            test: state.extra as CourseTestEntity,
          );
        },
      ),
      GoRoute(
        path: VideoConsequencesView.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return VideoConsequencesView(
            video: state.extra as CourseVideoItemEntity,
          );
        },
      ),
      GoRoute(
        path: FileConsequencesView.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return FileConsequencesView(
            file: state.extra as CourseFileEntity,
          );
        },
      ),
      GoRoute(
        path: SubscribtionView.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return SubscribtionView(
            requirmentsEntity: state.extra
                as DisplayCourseBottomsheetNavigationRequirmentsEntity,
          );
        },
      ),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/repos/CourseSubscibtionsRepo/CourseSubscibtionsRepo.dart';
import 'package:sintir/Core/repos/Test-Item-Repo/TestItemRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TestConsequencesViewRequirements.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/TestConsequencesViewBody.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/get_exam_results_cubit/get_exam_results_cubit.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/test_consequences_cubit/test_consequences_cubit.dart';

class TestConsequencesView extends StatelessWidget {
  const TestConsequencesView({super.key, required this.requirements});
  final TestConsequencesViewRequirements requirements;
  static const String routeName = "/TestConsequencesView";
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetExamResultsCubit(
            testItemRepo: getIt<Testitemrepo>(),
          ),
        ),
        BlocProvider(
            create: (context) => TestConsequencesCubit(
                courseSubscibtionsRepo: getIt<CourseSubscibtionsRepo>(),
                testRepo: getIt<Testitemrepo>()))
      ],
      child: Scaffold(
        appBar: const CustomAppBar(appBartitle: "التقارير الخاصة بالاختبار"),
        body: TestConsequencesViewBody(
          requirements: requirements,
        ),
      ),
    );
  }
}

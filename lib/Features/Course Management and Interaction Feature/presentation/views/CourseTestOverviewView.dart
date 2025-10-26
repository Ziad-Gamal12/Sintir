import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestViewNavigationsRequirmentsEntity.dart';
import 'package:sintir/Core/repos/Test-Item-Repo/TestItemRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/manager/GetUserPerviousResultsOfExam/get_user_pervious_results_of_exam_cubit.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestOverViewBodyWidgets/CourseTestOverViewBody.dart';

class CourseTestOverViewView extends StatelessWidget {
  const CourseTestOverViewView(
      {super.key, required this.coursetestviewnavigationsrequirmentsentity});
  final CourseExamViewNavigationsRequirmentsEntity
      coursetestviewnavigationsrequirmentsentity;
  static String routeName = '/CourseTestOverViewView';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetUserPerviousResultsOfExamCubit(
        testitemrepo: getIt<Testitemrepo>(),
      ),
      child: Scaffold(
        appBar: CustomAppBar(
            appBartitle: coursetestviewnavigationsrequirmentsentity.test.title),
        body: CourseTestOverViewBody(
          navigationRequirements: coursetestviewnavigationsrequirmentsentity,
        ),
      ),
    );
  }
}

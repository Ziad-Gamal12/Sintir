import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionSolutionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeachespaceEnvironmentTheme.dart';
import 'package:sintir/locale_keys.dart';

class CustomRemoveSolutionItem extends StatelessWidget {
  const CustomRemoveSolutionItem({
    super.key,
    required this.coursetestentity,
    required this.solution,
    required this.question,
  });

  final CourseTestEntity coursetestentity;
  final CourseTestQuestionSolutionEntity solution;
  final CourseTestQuestionEntity question;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: LocaleKeys.delete,
      onPressed: () {
        context.read<TestItemCubit>().removeSolutin(
          coursetestentity: coursetestentity,
          solution: solution,
          question: question,
        );
      },
      icon: FaIcon(
        FontAwesomeIcons.trashCan,
        size: 18,
        color: WorkEnvironmentThemeExtension.of(context).dangerForeground,
      ),
    );
  }
}

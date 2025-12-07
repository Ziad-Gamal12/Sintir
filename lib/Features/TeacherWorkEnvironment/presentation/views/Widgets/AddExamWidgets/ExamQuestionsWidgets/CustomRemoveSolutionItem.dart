import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionSolutionEntity.dart';

class CustomRemoveSolutionItem extends StatelessWidget {
  const CustomRemoveSolutionItem({
    super.key,
    required this.coursetestentity,
    required this.e,
    required this.question,
  });

  final CourseTestEntity coursetestentity;
  final MapEntry<int, CourseTestQuestionSolutionEntity> e;
  final CourseTestQuestionEntity question;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<TestItemCubit>().removeSolutin(
            coursetestentity: coursetestentity,
            solution: e.value,
            question: question);
      },
      icon: const Icon(
        FontAwesomeIcons.trashCan,
        color: Colors.red,
      ),
    );
  }
}

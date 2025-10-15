import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/AddcourseExamQuestionItemTextField.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/CustomQuestionSolutionsList.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionInputsQuestionHeader.dart';

class ExamQuestionInputs extends StatelessWidget {
  const ExamQuestionInputs({
    super.key,
    required this.courseTestEntity,
    required this.coursetestquestionentity,
    required this.index,
  });
  final CourseTestQuestionEntity coursetestquestionentity;
  final CourseTestEntity courseTestEntity;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xffF2F2F7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          ExamQuestionInputsQuestionHeader(
              index: index, totalQuestions: courseTestEntity.questions.length),
          const SizedBox(
            height: 20,
          ),
          AddcourseExamQuestionItemTextField(
            coursetestquestionentity: coursetestquestionentity,
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomQuestionSolutionsList(
                question: coursetestquestionentity,
                coursetestentity: courseTestEntity,
              ),
              const SizedBox(
                height: 10,
              ),
              Custombutton(
                  text: "اضافه أجابة",
                  color: Colors.red.shade400,
                  borderRadius: BorderRadius.circular(8),
                  textColor: Colors.white,
                  onPressed: () {
                    context.read<TestItemCubit>().addSolution(
                          question: coursetestquestionentity,
                        );
                  })
            ],
          )
        ],
      ),
    );
  }
}

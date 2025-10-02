import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/AddcourseExamQuestionItemTextField.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/CustomQuestionSolutionsList.dart';

class ExamQuestionInputs extends StatelessWidget {
  const ExamQuestionInputs({
    super.key,
    required this.courseTestEntity,
    required this.coursetestquestionentity,
  });
  final CourseTestQuestionEntity coursetestquestionentity;
  final CourseTestEntity courseTestEntity;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xffF2F2F7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
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
                  text: "اضافه جواب",
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(0),
                  textColor: Colors.black,
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

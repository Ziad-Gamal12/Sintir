import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddSqlTestWidgets/CustomQuestionSolutionsList.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddSqlTestWidgets/addcourseSQLTEstQuestionItemTextField.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/AddCourseSectionCubit/AddCourseSectionCubit.dart';

class SQLTestQuestionInputs extends StatelessWidget {
  const SQLTestQuestionInputs({
    super.key,
  });

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
          const AddcourseSQLTEstQuestionItemTextField(),
          const SizedBox(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CustomQuestionSolutionsList(),
              const SizedBox(
                height: 10,
              ),
              Custombutton(
                  text: "اضافه جواب",
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(0),
                  textColor: Colors.black,
                  onPressed: () {
                    context.read<AddCourseSectionCubit>().addSolution(
                          question: context.read<Coursetestquestionentity>(),
                        );
                  })
            ],
          )
        ],
      ),
    );
  }
}

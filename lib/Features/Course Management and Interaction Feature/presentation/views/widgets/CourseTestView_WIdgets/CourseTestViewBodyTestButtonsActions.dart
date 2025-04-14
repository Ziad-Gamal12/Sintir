// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestViewNavigationsRequirmentsEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/manager/update_course_sections_cubit/updatecoursesectionsCubit.dart';

class CourseTestViewBodyTestButtonsActions extends StatelessWidget {
  const CourseTestViewBodyTestButtonsActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Custombutton(
            text: "تسليم الأمتحان",
            color: Colors.red,
            textColor: Colors.white,
            onPressed: () {
              final cubit = context.read<UpdateCourseSectionsCubit>();
              final navEntity =
                  context.read<Coursetestviewnavigationsrequirmentsentity>();

              final newResult = cubit.getTestResultEntity(
                coursetestentity: navEntity.test,
                isDelivered: true,
                context: context,
              );
              navEntity.test.results.add(newResult);

              cubit.updateCourseSections(
                course: navEntity.course,
              );
            }),
        const SizedBox(
          height: 10,
        ),
        Custombutton(
            text: "اكمال الأمتحان لاحقا",
            color: Colors.yellow.shade700,
            textColor: Colors.white,
            onPressed: () {}),
      ],
    );
  }
}

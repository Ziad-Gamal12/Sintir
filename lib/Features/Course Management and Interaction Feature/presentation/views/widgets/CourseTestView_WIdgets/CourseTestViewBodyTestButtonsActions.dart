// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestViewNavigationsRequirmentsEntity.dart';

class CourseTestViewBodyTestButtonsActions extends StatelessWidget {
  const CourseTestViewBodyTestButtonsActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Coursetestviewnavigationsrequirmentsentity requirements =
        context.read<Coursetestviewnavigationsrequirmentsentity>();
    return BlocBuilder<CourseSectionsCubit, CourseSectionsState>(
      builder: (context, state) {
        return Custom_Loading_Widget(
          isLoading: state is AddTestResultLoading,
          child: Column(
            children: [
              Custombutton(
                  text: "تسليم الأمتحان",
                  color: Colors.red,
                  textColor: Colors.white,
                  onPressed: () {
                    context.read<CourseSectionsCubit>().addTestResults(
                        context: context,
                        test: requirements.test,
                        sectionId: requirements.sectionId,
                        sectionItemId: requirements.test.id,
                        courseId: requirements.course.id);
                  }),
            ],
          ),
        );
      },
    );
  }
}

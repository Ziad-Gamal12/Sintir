// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestViewNavigationsRequirmentsEntity.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';

class CourseTestViewBodyTestButtonsActions extends StatelessWidget {
  const CourseTestViewBodyTestButtonsActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    CourseExamViewNavigationsRequirmentsEntity requirements =
        context.read<CourseExamViewNavigationsRequirmentsEntity>();
    return BlocBuilder<TestItemCubit, TestItemState>(
      builder: (context, state) {
        return Custom_Loading_Widget(
          isLoading: state is AddTestResultLoading,
          child: Custombutton(
              text: "تسليم الأمتحان",
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                context.read<TestItemCubit>().addTestResults(
                    context: context,
                    test: requirements.test,
                    sectionId: requirements.sectionId,
                    sectionItemId: requirements.test.id,
                    courseId: requirements.course.id);
              }),
        );
      },
    );
  }
}

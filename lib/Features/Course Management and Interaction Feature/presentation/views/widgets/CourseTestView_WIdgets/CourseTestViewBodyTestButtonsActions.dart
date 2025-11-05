// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestViewNavigationsRequirmentsEntity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';

class CourseTestViewBodyTestButtonsActions extends StatelessWidget {
  const CourseTestViewBodyTestButtonsActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    CourseExamViewNavigationsRequirmentsEntity requirements =
        context.read<CourseExamViewNavigationsRequirmentsEntity>();
    UserEntity userData = getUserData();
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
                    userId: userData.uid,
                    sectionId: requirements.sectionId,
                    sectionItemId: requirements.test.id,
                    courseId: requirements.course.id);
              }),
        );
      },
    );
  }
}

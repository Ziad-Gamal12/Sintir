import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/update_test_cubit/update_test_cubit.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class UpdateTestInfoBottomSheetActionButton extends StatelessWidget {
  const UpdateTestInfoBottomSheetActionButton({
    super.key,
    required this.courseTestEntity,
    required this.examDetailsFormKey,
    required this.sectionId,
    required this.courseId,
  });
  final CourseTestEntity courseTestEntity;
  final GlobalKey<FormState> examDetailsFormKey;
  final String sectionId;
  final String courseId;
  @override
  Widget build(BuildContext context) {
    return BlocSelector<UpdateTestCubit, UpdateTestState, bool>(
      selector: (state) {
        return state is UpdateTestItemLoading;
      },
      builder: (context, isLoading) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: KHorizontalPadding,
            vertical: KVerticalPadding,
          ),
          child: Custom_Loading_Widget(
            isLoading: isLoading,
            child: Custombutton(
                text: LocaleKeys.save,
                color: KMainColor,
                textColor: Colors.white,
                onPressed: () {
                  if (examDetailsFormKey.currentState!.validate()) {
                    examDetailsFormKey.currentState!.save();
                    BlocProvider.of<UpdateTestCubit>(context).updateTestItem(
                      test: courseTestEntity,
                      courseId: courseId,
                      sectionId: sectionId,
                    );
                  }
                }),
          ),
        );
      },
    );
  }
}

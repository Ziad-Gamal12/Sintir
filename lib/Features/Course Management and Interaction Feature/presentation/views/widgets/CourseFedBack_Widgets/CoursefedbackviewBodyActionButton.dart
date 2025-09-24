import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseFeedBacksCubit/course_feed_backs_cubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomChatTextField.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursefedbackItemEntity.dart';

class CoursefedbackviewBodyActionButton extends StatelessWidget {
  const CoursefedbackviewBodyActionButton({
    super.key,
    required this.controller,
    required this.requirmentsEntity,
    required this.coursefedbackItemEntity,
    required this.formKey,
  });

  final TextEditingController controller;
  final DisplayCourseBottomsheetNavigationRequirmentsEntity requirmentsEntity;
  final CoursefeedbackItemEntity coursefedbackItemEntity;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return BlocSelector<CourseFeedBacksCubit, CourseFeedBacksState, bool>(
      selector: (state) {
        return state is CourseFeedBacksAddFeedBackLoading;
      },
      builder: (context, state) {
        return CustomChatTextField(
            controller: controller,
            isLoading: state,
            onPressed: () {
              if (requirmentsEntity.isSubscribed == true) {
                if (formKey.currentState!.validate()) {
                  coursefedbackItemEntity.fedBack = controller.text;
                  context.read<CourseFeedBacksCubit>().addCourseFeedBack(
                      courseId: requirmentsEntity.course.id,
                      feedback: coursefedbackItemEntity);
                }
              } else {
                errordialog(context, "يجب الاشتراك في الدورة لارسال التعليق")
                    .show();
              }
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "لا يمكن ان يكون الحقل فارغ";
              }
              return null;
            });
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseFeedBacksCubit/course_feed_backs_cubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
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
    return CustomChatTextField(
        controller: controller,
        onPressed: () {
          if (requirmentsEntity.isSubscribed == true) {
            if (formKey.currentState!.validate()) {
              context.read<CourseFeedBacksCubit>().addCourseFeedBack(
                  courseId: requirmentsEntity.course.id,
                  feedback: coursefedbackItemEntity);
            }
          }
        },
        validator: (value) {
          if (value!.isEmpty) {
            return "لا يمكن ان يكون الحقل فارغ";
          }
          return null;
        });
  }
}

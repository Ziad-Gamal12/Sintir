// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseVedioItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/AddCourseSectionCubit/AddCourseSectionCubit.dart';
import 'package:sintir/constant.dart';

class CustomAddCourseVideoSectionButton extends StatelessWidget {
  const CustomAddCourseVideoSectionButton({
    super.key,
    required this.coursevedioitementity,
  });
  final Coursevedioitementity coursevedioitementity;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCourseSectionCubit, AddCourseSectionState>(
      builder: (context, state) {
        return Custom_Loading_Widget(
          isLoading: state is VideoUploadedingLoading ||
              state is UpdateCourseSectionsLoading,
          child: Custombutton(
              text: coursevedioitementity.file == null
                  ? "تحديد فديو"
                  : "أضافةالفديو",
              color: coursevedioitementity.file == null
                  ? KSecondaryColor
                  : Colors.green,
              textColor: Colors.white,
              onPressed: () {
                if (coursevedioitementity.file == null) {
                  context.read<AddCourseSectionCubit>().pickSectionVedio(
                      coursevedioitementity: coursevedioitementity);
                } else {
                  if (Variables.AddCourseSectionVideoItemFormKey.currentState!
                      .validate()) {
                    context.read<AddCourseSectionCubit>().uploadVideo(
                        coursevedioitementity: coursevedioitementity);
                  }
                }
              }),
        );
      },
    );
  }
}

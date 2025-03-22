import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/AddCourseSectionCubit/AddCourseSectionCubit.dart';
import 'package:sintir/constant.dart';

class CustomAddCourseVideoSectionButton extends StatelessWidget {
  const CustomAddCourseVideoSectionButton({
    super.key,
    required this.vedioFile,
    required this.formKey,
    required this.courseEntity,
  });

  final File? vedioFile;
  final GlobalKey<FormState> formKey;
  final CourseEntity courseEntity;

  @override
  Widget build(BuildContext context) {
    return Custombutton(
        text: vedioFile == null ? "تحديد فديو" : "أضافةالفديو",
        color: vedioFile == null ? KSecondaryColor : Colors.green,
        textColor: Colors.white,
        onPressed: () {
          if (vedioFile == null) {
            context.read<AddCourseSectionCubit>().pickSectionVedio();
          } else {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              context.read<AddCourseSectionCubit>().addVideo(
                    coursevedioitementity: context
                        .read<AddCourseSectionCubit>()
                        .coursevedioitementity,
                    section: context
                        .read<AddCourseSectionCubit>()
                        .coursSectionsListItemEntity,
                    courseEntity: courseEntity,
                  );
            }
          }
        });
  }
}

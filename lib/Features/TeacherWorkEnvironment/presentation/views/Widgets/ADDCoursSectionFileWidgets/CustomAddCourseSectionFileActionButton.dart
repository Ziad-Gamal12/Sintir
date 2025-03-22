import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/AddCourseSectionCubit/AddCourseSectionCubit.dart';
import 'package:sintir/constant.dart';

class CustomAddCourseSectionFileActionButton extends StatelessWidget {
  const CustomAddCourseSectionFileActionButton({
    super.key,
    required this.formKey,
  });
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    var fileentity = context.read<Coursefileentity>();
    return BlocBuilder<AddCourseSectionCubit, AddCourseSectionState>(
      builder: (context, state) {
        return Custombutton(
            text: fileentity.file != null ? "اضافة الملف" : "تحديد الملف",
            color: fileentity.file != null ? Colors.green : KSecondaryColor,
            textColor: Colors.white,
            onPressed: () {
              if (fileentity.file == null) {
                BlocProvider.of<AddCourseSectionCubit>(context)
                    .pickSectionFile();
              } else {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  BlocProvider.of<AddCourseSectionCubit>(context).addFile(
                      file: fileentity,
                      section: context
                          .read<AddCourseSectionCubit>()
                          .coursSectionsListItemEntity,
                      courseEntity: context.read<CourseEntity>());
                }
              }
            });
      },
    );
  }
}

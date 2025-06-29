import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/file_item_cubit/file_item_cubit.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';
import 'package:sintir/constant.dart';

class CustomAddCourseSectionFileActionButton extends StatelessWidget {
  const CustomAddCourseSectionFileActionButton({
    super.key,
    required this.formKey,
    required this.fileentity,
  });
  final CourseFileEntity fileentity;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FileItemCubit, FileItemState>(
      builder: (context, state) {
        return Custom_Loading_Widget(
          isLoading: state is UplaodFileLoading || state is AddFileItemLoading,
          child: Custombutton(
              text: fileentity.file != null ? "اضافة الملف" : "تحديد الملف",
              color: fileentity.file != null ? Colors.green : KSecondaryColor,
              textColor: Colors.white,
              onPressed: () {
                if (fileentity.file == null) {
                  BlocProvider.of<FileItemCubit>(context).pickSectionFile();
                } else {
                  if (formKey.currentState!.validate()) {
                    BlocProvider.of<FileItemCubit>(context).uploadFile(
                      coursefileEntity: fileentity,
                    );
                  }
                }
              }),
        );
      },
    );
  }
}

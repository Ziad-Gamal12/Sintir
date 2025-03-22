// ignore_for_file: must_be_immutable, file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Core/widgets/Video%20Previewer%20Widgets/CustomDisplayingVedioWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseVedioItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/CustomAddCourseVideoSectionButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/AddCourseSectionCubit/AddCourseSectionCubit.dart';
import 'package:sintir/constant.dart';

class Addcoursesectionvedioviewbody extends StatelessWidget {
  Addcoursesectionvedioviewbody({super.key, required this.courseEntity});
  File? vedioFile;
  final CourseEntity courseEntity;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCourseSectionCubit, AddCourseSectionState>(
      listener: (context, state) {
        if (state is AddCourseSectionVedioPicked) {
          vedioFile = state.vedioFile;
        } else if (state is AddCourseSectionVedioUnPicked) {
          vedioFile = null;
        } else if (state is AddCourseSectionAddSectionSuccess) {
          successdialog(
                  context: context,
                  SuccessMessage: "تم اضافة الفديو بنجاح",
                  btnOkOnPress: () {})
              .show();
        } else if (state is AddCourseSectionAddSectionFailure) {
          errordialog(context, state.errMessage).show();
        }
      },
      builder: (context, state) => Stack(
        children: [
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: KHorizontalPadding, vertical: KVerticalPadding),
              child: Column(
                children: [
                  Customteaxtfield(
                      hintText: "يرجى كتابه أسم الفديو هنا ...",
                      obscureText: false,
                      textInputType: TextInputType.text,
                      onSaved: (value) {
                        context.read<Coursevedioitementity>().title = value!;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "ادخل اسم الفديو";
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  vedioFile == null
                      ? const SizedBox()
                      : CustomDisplayingVideoWidget(
                          durtationChanged: (value) {
                            context.read<Coursevedioitementity>().durationTime =
                                value;
                          },
                          file: vedioFile,
                        )
                ],
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 32,
            child: Custom_Loading_Widget(
                isLoading: state is AddCourseSectionAddSectionLoading,
                child: CustomAddCourseVideoSectionButton(
                    vedioFile: vedioFile,
                    formKey: formKey,
                    courseEntity: courseEntity)),
          )
        ],
      ),
    );
  }
}

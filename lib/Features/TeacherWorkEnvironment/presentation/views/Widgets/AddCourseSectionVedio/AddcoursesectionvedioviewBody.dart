// ignore_for_file: must_be_immutable, file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomDisplayingVedioWidget.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseVedioItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/AddCourseSectionCubit/AddCourseSectionCubit.dart';
import 'package:sintir/constant.dart';

class Addcoursesectionvedioviewbody extends StatelessWidget {
  Addcoursesectionvedioviewbody({super.key});
  File? vedioFile;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCourseSectionCubit, AddCourseSectionState>(
      listener: (context, state) {
        if (state is AddCourseSectionVedioPicked) {
          vedioFile = state.vedioFile;
        } else if (state is AddCourseSectionVedioUnPicked) {
          vedioFile = null;
        }
      },
      builder: (context, state) => Stack(
        children: [
          Padding(
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
                    : Customdisplayingvediowidget(
                        file: vedioFile,
                      )
              ],
            ),
          ),
          Positioned(
              left: 16,
              right: 16,
              bottom: 32,
              child: Custombutton(
                  text: vedioFile == null ? "تحديد فديو" : "أضافةالفديو",
                  color: vedioFile == null ? KSecondaryColor : Colors.green,
                  textColor: Colors.white,
                  onPressed: () {
                    if (vedioFile == null) {
                      context.read<AddCourseSectionCubit>().pickSectionVedio();
                    }
                  }))
        ],
      ),
    );
  }
}

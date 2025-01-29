import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCoursePoster.dart';

class AddCourseInputs extends StatelessWidget {
  const AddCourseInputs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Customteaxtfield(
            hintText: "يرجى كتابه أسم الدورة هنا ...",
            obscureText: false,
            controller: Variables.AddCourseCourseNameController,
            textInputType: TextInputType.text,
            validator: (value) {
              if (value!.isEmpty) {
                return "ادخل اسم الدورة";
              }
              return null;
            }),
        const SizedBox(
          height: 10,
        ),
        Customteaxtfield(
            hintText: "يرجى تقديم وصف مختصر للأهداف الرئيسية للدورة..",
            obscureText: false,
            controller: Variables.AddCourseCourseDescriptionController,
            textInputType: TextInputType.text,
            maxLines: 5,
            validator: (value) {
              if (value!.isEmpty) {
                return "ادخل وصف للدورة";
              }
              return null;
            }),
        const SizedBox(
          height: 10,
        ),
        Customteaxtfield(
            hintText: "المرحلة الدراسيه",
            obscureText: false,
            controller: Variables.AddCourseCourseLevelController,
            textInputType: TextInputType.text,
            validator: (value) {
              if (value!.isEmpty) {
                return "ادخل المرحلة الدراسية";
              }
              return null;
            }),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Customteaxtfield(
                      hintText: "المادة",
                      obscureText: false,
                      controller: Variables.AddCourseCourseSubjectController,
                      textInputType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "ادخل المادة";
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  Customteaxtfield(
                      hintText: "اللغة",
                      obscureText: false,
                      controller: Variables.AddCourseCourseLanguageController,
                      textInputType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "ادخل اللغة";
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  Customteaxtfield(
                      hintText: "السعر بالجنية المصرى",
                      obscureText: false,
                      controller: Variables.AddCourseCourseLevelController,
                      textInputType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "ادخل السعر بالجنية المصرى";
                        }
                        return null;
                      }),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Expanded(
              child: Addcourseposter(),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Customteaxtfield(
            hintText: "رقم فودافون كاش ",
            obscureText: false,
            controller: Variables.AddCourseCoursePhoneController,
            textInputType: TextInputType.text,
            validator: (value) {
              if (value!.isEmpty) {
                return "ادخل رقم فودافون كاش";
              }
              return null;
            }),
      ],
    );
  }
}

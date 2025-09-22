import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseViewWidgets/AddCoursePoster.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/AddCourseCubit/add_course_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AddCourseInputs extends StatelessWidget {
  const AddCourseInputs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCourseCubitCubit, AddCourseCubitState>(
      builder: (context, state) => Column(
        children: [
          CustomTextField(
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
          CustomTextField(
              hintText: "يرجى كتابه كود الدورة هنا ...",
              obscureText: false,
              controller: Variables.AddCourseCourseCodeController,
              textInputType: TextInputType.text,
              validator: (value) {
                if (value!.isEmpty) {
                  return "ادخل كود الدورة";
                }
                return null;
              }),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
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
          CustomTextField(
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
                    CustomTextField(
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
                    CustomTextField(
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
                    CustomTextField(
                        hintText: "السعر بالجنية المصرى",
                        obscureText: false,
                        controller: Variables.AddCourseCoursePriceController,
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
              Expanded(
                child: Skeletonizer(
                  enabled: state is AddCourseCubitAssetLoading,
                  child: Addcourseposter(
                    coursePosterImage:
                        context.read<AddCourseCubitCubit>().coursePosterImage,
                    onTap: () {
                      context
                          .read<AddCourseCubitCubit>()
                          .pickCoursePosterImage();
                    },
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
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
      ),
    );
  }
}

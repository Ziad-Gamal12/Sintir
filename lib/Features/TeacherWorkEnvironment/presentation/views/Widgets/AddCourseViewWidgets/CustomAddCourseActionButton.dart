import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/AddCourseCubit/add_course_cubit.dart';
import 'package:sintir/constant.dart';

class CustomAddCourseActionButton extends StatelessWidget {
  const CustomAddCourseActionButton({
    super.key,
    required this.formKey,
    required this.selectedLevel,
    required this.selectedSubject,
    required this.titleController,
    required this.codeController,
    required this.descriptionController,
    required this.priceController,
    required this.selectedLanguage,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController codeController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;

  final String? selectedLevel;
  final String? selectedSubject;
  final String? selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddCourseCubitCubit, AddCourseCubitState, bool>(
      selector: (state) {
        return state is AddCourseCubitLoading;
      },
      builder: (context, state) {
        return Custom_Loading_Widget(
            isLoading: state,
            child: Custombutton(
                text: "التالى",
                color: KMainColor,
                textColor: Colors.white,
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;

                  if (selectedLevel == null ||
                      selectedSubject == null ||
                      selectedLanguage == null) {
                    errordialog(context, "هناك خانات ناقصة").show();
                    return;
                  }

                  if (context.read<AddCourseCubitCubit>().coursePosterImage ==
                      null) {
                    errordialog(context, "يرجى إضافة صورة للدورة").show();
                    return;
                  }

                  final course = CourseEntity(
                    studentsCount: 0,
                    subject: selectedSubject!,
                    id: codeController.text,
                    level: selectedLevel!,
                    state: BackendEndpoints.coursePendingState,
                    title: titleController.text,
                    description: descriptionController.text,
                    price: int.parse(priceController.text),
                    language: selectedLanguage!,
                    postedDate: DateTime.now(),
                  );

                  context.read<AddCourseCubitCubit>().addCourse(
                        courseEntity: course,
                        userEntity: getUserData(),
                      );

                  if (selectedLanguage == null ||
                      selectedLevel == null ||
                      selectedSubject == null) {
                    context.read<AddCourseCubitCubit>().addCourse(
                        courseEntity: course, userEntity: getUserData());
                  }
                }));
      },
    );
  }
}

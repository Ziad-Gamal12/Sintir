import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/AddCourseCubit/add_course_cubit.dart';
import 'package:sintir/constant.dart';

class CustomAddCourseActionButton extends StatelessWidget {
  const CustomAddCourseActionButton({
    super.key,
    required this.formKey,
    required this.state,
  });

  final GlobalKey<FormState> formKey;
  final AddCourseCubitState state;
  @override
  Widget build(BuildContext context) {
    return Custom_Loading_Widget(
      isLoading: state is AddCourseCubitLoading,
      child: Custombutton(
          text: "التالى",
          color: KMainColor,
          textColor: Colors.white,
          onPressed: () {
            if (formKey.currentState!.validate()) {
              if (context.read<AddCourseCubitCubit>().coursePosterImage !=
                  null) {
                CourseEntity course = CourseEntity(
                  studentsCount: 0,
                  id: Variables.AddCourseCourseCodeController.text,
                  state: BackendEndpoints.coursePendingState,
                  title: Variables.AddCourseCourseNameController.text,
                  description:
                      Variables.AddCourseCourseDescriptionController.text,
                  price:
                      int.parse(Variables.AddCourseCoursePriceController.text),
                  language: Variables.AddCourseCourseLanguageController.text,
                  postedDate:
                      "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
                );
                context
                    .read<AddCourseCubitCubit>()
                    .addCourse(courseEntity: course, userEntity: getUserData());
              } else {
                errordialog(context, "يرجى اضافة صورة للدورة").show();
              }
            }
          }),
    );
  }
}

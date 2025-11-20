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
      selector: (state) => state is AddCourseCubitLoading,
      builder: (context, isLoading) {
        return Custom_Loading_Widget(
          isLoading: isLoading,
          child: Custombutton(
            text: "إضافة",
            color: KMainColor,
            textColor: Colors.white,
            onPressed: isLoading ? () {} : () => _submitCourse(context),
          ),
        );
      },
    );
  }

  void _showMissingFieldsDialog(BuildContext context) {
    errordialog(context, "هناك خانات ناقصة").show();
  }

  void _showMissingImageDialog(BuildContext context) {
    errordialog(context, "يرجى إضافة صورة للدورة").show();
  }

  void _showInvalidPriceDialog(BuildContext context) {
    errordialog(context, "الرجاء إدخال سعر صحيح").show();
  }

  void _submitCourse(BuildContext context) {
    FocusScope.of(context).unfocus();

    final cubit = context.read<AddCourseCubitCubit>();

    if (!formKey.currentState!.validate()) return;

    if (selectedLevel == null ||
        selectedSubject == null ||
        selectedLanguage == null) {
      _showMissingFieldsDialog(context);
      return;
    }

    if (cubit.coursePosterImage == null) {
      _showMissingImageDialog(context);
      return;
    }

    final priceText = priceController.text.trim();
    final price = int.tryParse(priceText);
    if (price == null || price < 0) {
      _showInvalidPriceDialog(context);
      return;
    }

    final course = CourseEntity(
      studentsCount: 0,
      subject: selectedSubject!,
      id: codeController.text.trim(),
      level: selectedLevel!,
      state: BackendEndpoints.coursePendingState,
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      price: price,
      language: selectedLanguage!,
      postedDate: DateTime.now(),
    );

    // Show a confirmation warning before actually adding
    warningdialog(
      context,
      "هام! سيتم خصم نسبه 5% من السعر المحدد عند الأشتراك",
      () {
        cubit.addCourse(courseEntity: course, userEntity: getUserData());
      },
    ).show();
  }
}

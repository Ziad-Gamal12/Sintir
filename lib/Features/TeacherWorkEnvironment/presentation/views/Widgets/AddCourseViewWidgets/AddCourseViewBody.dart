import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseViewWidgets/CourseInputsCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseViewWidgets/CustomAddCourseActionButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/AddCourseCubit/add_course_cubit.dart';

class AddCourseViewBody extends StatefulWidget {
  const AddCourseViewBody({super.key});

  @override
  State<AddCourseViewBody> createState() => _AddCourseViewBodyState();
}

class _AddCourseViewBodyState extends State<AddCourseViewBody> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final codeController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  String? selectedLanguage;
  String? selectedLevel;
  String? selectedSubject;

  @override
  void dispose() {
    titleController.dispose();
    codeController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCourseCubitCubit, AddCourseCubitState>(
      listener: (context, state) {
        if (state is AddCourseCubitSuccess) {
          successdialog(
            context: context,
            SuccessMessage: "تم إرسال طلب الدورة بنجاح… سيتم المراجعة قريباً",
            btnOkOnPress: () => GoRouter.of(context).pop(),
          ).show();
        }
        if (state is AddCourseCubitFailure) {
          errordialog(context, state.errmessage).show();
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                CourseInputsCard(
                  titleController: titleController,
                  codeController: codeController,
                  descriptionController: descriptionController,
                  priceController: priceController,
                  onLevelChange: (v) => setState(() => selectedLevel = v),
                  onSubjectChange: (v) => setState(() => selectedSubject = v),
                  onLanguageChange: (v) => setState(() => selectedLanguage = v),
                ),
                const SizedBox(height: 50),
                CustomAddCourseActionButton(
                  formKey: formKey,
                  titleController: titleController,
                  codeController: codeController,
                  descriptionController: descriptionController,
                  priceController: priceController,
                  selectedLanguage: selectedLanguage,
                  selectedLevel: selectedLevel,
                  selectedSubject: selectedSubject,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

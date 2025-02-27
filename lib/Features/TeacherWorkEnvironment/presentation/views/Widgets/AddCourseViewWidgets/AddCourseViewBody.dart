// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseViewWidgets/AddCourseInputs.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseViewWidgets/CustomAddCourseActionButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/AddCourseCubit/add_course_cubit.dart';
import 'package:sintir/constant.dart';

class Addcourseviewbody extends StatelessWidget {
  Addcourseviewbody({super.key});
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCourseCubitCubit, AddCourseCubitState>(
      listener: (context, state) {
        if (state is AddCourseCubitSuccess) {
          successdialog(
              context: context,
              SuccessMessage:
                  "تم أرسال الطلب بنجاح , و سيتم مراجعته في اقرب وقت",
              btnOkOnPress: () {
                GoRouter.of(context).pop();
              }).show();
        } else if (state is AddCourseCubitFailure) {
          errordialog(context, state.errmessage).show();
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const AddCourseInputs(),
                const SizedBox(
                  height: 60,
                ),
                CustomAddCourseActionButton(state: state, formKey: formKey),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

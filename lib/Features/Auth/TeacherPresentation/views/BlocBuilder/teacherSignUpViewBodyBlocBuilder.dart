// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/widgets/CustomTermsAndConditiona.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/manager/TeacherSignUP/teacher_sign_up_cubit.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/Sections/TeacherSignUPTextFieldsSection.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/teacherTermsAndConditionsView.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/widgets/TeacherSignUpViewBodyHaveAnAccountText.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/widgets/teacherSignUpViewBodyCustomButton.dart';
import 'package:sintir/constant.dart';

// ignore: must_be_immutable
class teacherSignUpViewBodyBlocBuilder extends StatefulWidget {
  const teacherSignUpViewBodyBlocBuilder({
    super.key,
  });

  @override
  State<teacherSignUpViewBodyBlocBuilder> createState() =>
      _teacherSignUpViewBodyBlocBuilderState();
}

class _teacherSignUpViewBodyBlocBuilderState
    extends State<teacherSignUpViewBodyBlocBuilder> {
  bool isChecked = false;
  late GlobalKey<FormState> teacherSignUpFormKey;
  late TextEditingController teacherSignUpPasswordController;
  @override
  void initState() {
    super.initState();
    teacherSignUpPasswordController = TextEditingController();
    teacherSignUpFormKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    teacherSignUpPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TeacherSignUpCubit, TeacherSignUpState, bool>(
      selector: (state) {
        return state is TeacherSignUpLoading;
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Form(
            key: teacherSignUpFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: KHorizontalPadding, vertical: KVerticalPadding),
              child: Column(
                children: [
                  TeacherSignUPTextFieldsSection(
                    teacherSignUpPasswordController:
                        teacherSignUpPasswordController,
                  ),
                  const SizedBox(height: 16),
                  CustomTermsAndConditions(textOnPressed: () {
                    GoRouter.of(context)
                        .push(Teachertermsandconditionsview.routeName);
                  }, onChanged: (value) {
                    isChecked = value;
                    setState(() {});
                  }),
                  const SizedBox(
                    height: 32,
                  ),
                  Custom_Loading_Widget(
                    isLoading: state,
                    child: TeacherSignUpButton(
                      teacherSignUpPasswordController:
                          teacherSignUpPasswordController,
                      isChecked: isChecked,
                      formKey: teacherSignUpFormKey,
                    ),
                  ),
                  const SizedBox(height: 32),
                  const TeacherSignUpViewBodyHaveAnAccountText()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

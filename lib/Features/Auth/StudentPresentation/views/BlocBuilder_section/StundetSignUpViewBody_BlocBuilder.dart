// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/widgets/CustomTermsAndConditiona.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Features/Auth/StudentPresentation/manager/student_sign_up_cubit/student_sign_up_cubit.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/StudentTermsAndConditions_View.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/widgets/StudentSignUpBirthDateAndSchoolNameAndGenderSection.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/widgets/StudentSignUpFirstAndLastNameField.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/widgets/StudentSignUpHaveAnAccountTextWidget.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/widgets/StudentSignUpPhoneNumberFiled.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/widgets/StudentSignUpViewBodyBlocBuilder_button.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/widgets/StudentSignUpemailaddressfiled.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/widgets/studentSignUp_passwordField.dart';
import 'package:sintir/constant.dart';

class StundetSignUpViewBody_BlocBuilder extends StatefulWidget {
  const StundetSignUpViewBody_BlocBuilder({
    super.key,
    required this.state,
  });
  final StudentSignUpState state;

  @override
  State<StundetSignUpViewBody_BlocBuilder> createState() =>
      _StundetSignUpViewBody_BlocBuilderState();
}

class _StundetSignUpViewBody_BlocBuilderState
    extends State<StundetSignUpViewBody_BlocBuilder> {
  bool isTermsAndConditionChecked = false;
  late TextEditingController studentSignUpPasswordController;
  late GlobalKey<FormState> studentSignUpFormKey;
  @override
  void initState() {
    super.initState();
    studentSignUpPasswordController = TextEditingController();
    studentSignUpFormKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    studentSignUpPasswordController.dispose();
    studentSignUpFormKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: studentSignUpFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: KHorizontalPadding, vertical: KVerticalPadding),
          child: SingleChildScrollView(
            child: Column(spacing: 12, children: [
              const StudentSignUpFirstAndLastNameField(),
              const StudentSignUpemailaddressfiled(),
              const StudentSignUpPhoneNumberFiled(),
              const StudentSignUpBirthDateAndSchoolNameAndGenderSection(),
              StudentSignUpPasswordField(
                studentSignUpPasswordController:
                    studentSignUpPasswordController,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTermsAndConditions(textOnPressed: () {
                GoRouter.of(context)
                    .push(StudenttermsandconditionsView.routeName);
              }, onChanged: (value) {
                isTermsAndConditionChecked = value;
                setState(() {});
              }),
              const SizedBox(
                height: 16,
              ),
              Custom_Loading_Widget(
                  isLoading:
                      widget.state is StudentSignUpLoading ? true : false,
                  child: StudentSignUpViewBodyBlocBuilder_button(
                    stundentSignUpFormKey: studentSignUpFormKey,
                    isTermsAndConditionChecked: isTermsAndConditionChecked,
                    studentSignUpPasswordController:
                        studentSignUpPasswordController,
                  )),
              const SizedBox(
                height: 16,
              ),
              const StudentSignUpHaveAnAccountTextWidget(),
            ]),
          ),
        ));
  }
}

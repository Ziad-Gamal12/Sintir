// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/widgets/AdaptiveFormRow.dart';
import 'package:sintir/Core/widgets/CustomTermsAndConditiona.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Core/widgets/GenderSegmentedInput.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/Auth/StudentPresentation/manager/student_sign_up_cubit/student_sign_up_cubit.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/StudentTermsAndConditions_View.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/widgets/CustomStudentSignUP_SchoolLevel.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/widgets/StudentSignUpFirstAndLastNameField.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/widgets/StudentSignUpHaveAnAccountTextWidget.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/widgets/StudentSignUpPhoneNumberFiled.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/widgets/StudentSignUpViewBodyBlocBuilder_button.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/widgets/StudentSignUp_BirthDayField.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/widgets/StudentSignUpemailaddressfiled.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/widgets/studentSignUp_passwordField.dart';

/// The student sign-up form only. Padding, scrolling and the page layout
/// come from [AuthShell] in StudentSignupView. Paired fields share a row
/// once the form is wide enough (tablets); on phones they stack.
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
    studentSignUpPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: studentSignUpFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12,
        children: [
          const StudentSignUpFirstAndLastNameField(),
          const AdaptiveFormRow(
            children: [
              StudentSignUpemailaddressfiled(),
              StudentSignUpPhoneNumberFiled(),
            ],
          ),
          const AdaptiveFormRow(
            children: [
              StudentsignupBirthdayfield(),
              CustomstudentsignupSchoollevel(),
            ],
          ),
          AdaptiveFormRow(
            children: [
              GenderSegmentedInput(
                initialValue: context.read<UserEntity>().gender,
                onChanged: (value) =>
                    context.read<UserEntity>().gender = value,
              ),
              StudentSignUpPasswordField(
                studentSignUpPasswordController:
                    studentSignUpPasswordController,
              ),
            ],
          ),
          const SizedBox(height: 4),
          CustomTermsAndConditions(textOnPressed: () {
            GoRouter.of(context).push(StudenttermsandconditionsView.routeName);
          }, onChanged: (value) {
            isTermsAndConditionChecked = value;
            setState(() {});
          }),
          const SizedBox(height: 4),
          Custom_Loading_Widget(
              isLoading: widget.state is StudentSignUpLoading,
              child: StudentSignUpViewBodyBlocBuilder_button(
                stundentSignUpFormKey: studentSignUpFormKey,
                isTermsAndConditionChecked: isTermsAndConditionChecked,
                studentSignUpPasswordController:
                    studentSignUpPasswordController,
              )),
          const SizedBox(height: 4),
          const Center(child: StudentSignUpHaveAnAccountTextWidget()),
        ],
      ),
    );
  }
}

// ignore_for_file: file_names, camel_case_types

import 'package:dropdown_model_list/drop_down/model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Core/widgets/CustomTermsAndConditiona.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Features/StudenetAuth/presentation/manager/student_sign_up_cubit/student_sign_up_cubit.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/StudentTermsAndConditions_View.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/widgets/CustomStudentSignUP_SchoolLevel.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/widgets/StudentSignUpBirthDateAndSchoolNameAndGenderSection.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/widgets/StudentSignUpFirstAndLastNameField.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/widgets/StudentSignUpHaveAnAccountTextWidget.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/widgets/StudentSignUpPhoneNumberFiled.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/widgets/StudentSignUpViewBodyBlocBuilder_button.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/widgets/StudentSignUpemailaddressfiled.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/widgets/studentSignUp_passwordField.dart';
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
  String? radioValue;
  OptionItem? selectedItem;
  DateTime? birthDayDate;
  bool isTermsAndConditionChecked = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: Variables.StudnetSignUpFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
        child: SingleChildScrollView(
          child: Column(children: [
            const Customsizedbox(width: 0, height: 20),
            const StudentSignUpFirstAndLastNameField(),
            const Customsizedbox(width: 0, height: 10),
            const StudentSignUpemailaddressfiled(),
            const Customsizedbox(width: 0, height: 10),
            const StudentSignUpPhoneNumberFiled(),
            const Customsizedbox(width: 0, height: 10),
            StudentSignUpBirthDateAndSchoolNameAndGenderSection(
                radioValue: radioValue,
                gender: (value) {
                  radioValue = value;
                  setState(() {});
                },
                birhdaydate: (value) {
                  birthDayDate = value;
                  setState(() {});
                }),
            const Customsizedbox(width: 0, height: 10),
            CustomstudentsignupSchoollevel(
              selectedOption: (value) {
                selectedItem = value;
                setState(() {});
              },
            ),
            const Customsizedbox(width: 0, height: 10),
            const StudentsignupPasswordfield(),
            const Customsizedbox(width: 0, height: 20),
            Customtermsandconditiona(textonpressed: () {
              GoRouter.of(context)
                  .push(StudenttermsandconditionsView.routeName);
            }, onchanged: (value) {
              isTermsAndConditionChecked = value;
              setState(() {});
            }),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Custom_Loading_Widget(
              isLoading: widget.state is StudentSignUpLoading ? true : false,
              child: StudentSignUpViewBodyBlocBuilder_button(
                  stundentSignUpFormKey: Variables.StudnetSignUpFormKey,
                  isTermsAndConditionChecked: isTermsAndConditionChecked,
                  radioValue: radioValue,
                  birthDayDate: birthDayDate,
                  selectedItem: selectedItem),
            ),
            const Customsizedbox(width: 0, height: 20),
            const StudentSignUpHaveAnAccountTextWidget(),
            const Customsizedbox(width: 0, height: 20),
          ]),
        ),
      ),
    );
  }
}

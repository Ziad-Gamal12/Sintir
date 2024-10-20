// ignore_for_file: file_names, camel_case_types

import 'package:dropdown_model_list/drop_down/model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Core/widgets/CustomTermsAndConditiona.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Features/StudenetAuth/presentation/manager/student_sign_up_cubit/student_sign_up_cubit.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/StudentTermsAndConditions_View.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/widgets/CustomStudentSignUP_SchoolLevel.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/widgets/StudentGenderSelectionInput.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/widgets/StudentSignUpFirstAndLastNameField.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/widgets/StudentSignUpPhoneNumberFiled.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/widgets/StudentSignUpSchoolName.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/widgets/StudentSignUpViewBodyBlocBuilder_button.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/widgets/StudentSignUp_BirthDayField.dart';
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
    double width = MediaQuery.of(context).size.width;
    return Custom_Loading_Widget(
      isLoading: widget.state is StudentSignUpLoading ? true : false,
      child: Form(
        key: Variables.StudnetSignUpFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
          child: SingleChildScrollView(
            child: Column(children: [
              const Customsizedbox(width: 0, height: 28),
              StudentSignUpFirstAndLastNameField(width: width),
              const Customsizedbox(width: 0, height: 10),
              const StudentSignUpemailaddressfiled(),
              const Customsizedbox(width: 0, height: 10),
              const StudentSignUpPhoneNumberFiled(),
              const Customsizedbox(width: 0, height: 10),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          StudentsignupBirthdayfield(
                            width: width,
                            birhdaydate: (value) {
                              setState(() {
                                birthDayDate = value;
                              });
                            },
                          ),
                          const Customsizedbox(width: 0, height: 10),
                          const Studentsignupschoolname()
                        ],
                      )),
                  const Customsizedbox(width: 0, height: 10),
                  StudentGenderSelectionInput(
                      onChanged: (value) {
                        setState(() {
                          radioValue = value;
                        });
                      },
                      radiovalue: radioValue ?? "ذكر",
                      expandedFlex: 2)
                ],
              ),
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
                height: MediaQuery.of(context).size.height * 0.12,
              ),
              StudentSignUpViewBodyBlocBuilder_button(
                  stundentSignUpFormKey: Variables.StudnetSignUpFormKey,
                  isTermsAndConditionChecked: isTermsAndConditionChecked,
                  radioValue: radioValue,
                  birthDayDate: birthDayDate,
                  selectedItem: selectedItem),
              const Customsizedbox(width: 0, height: 20),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: "تمتلك حساب بالفعل ؟ ",
                    style: AppTextStyles.semiBold16
                        .copyWith(color: const Color(0xff949D9E))),
                TextSpan(
                    text: "تسجيل الدخول",
                    style: AppTextStyles.semiBold16.copyWith(color: KMainColor))
              ])),
              const Customsizedbox(width: 0, height: 20),
            ]),
          ),
        ),
      ),
    );
  }
}

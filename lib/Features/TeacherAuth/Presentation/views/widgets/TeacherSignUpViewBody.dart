import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Core/widgets/CustomTermsAndConditiona.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/manager/TeacherSignUP/teacher_sign_up_cubit.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/Sections/TeacherSignUPTextFieldsSection.dart';
import 'package:sintir/constant.dart';

class TeacherSignUpViewBody extends StatefulWidget {
  const TeacherSignUpViewBody({super.key});

  @override
  State<TeacherSignUpViewBody> createState() => _TeacherSignUpViewBodyState();
}

class _TeacherSignUpViewBodyState extends State<TeacherSignUpViewBody> {
  String? radiovalue;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocConsumer<TeacherSignUpCubit, TeacherSignUpState>(
      listener: (context, state) {
        if (state is TeacherSignUpSuccess) {
          GoRouter.of(context).pop();
        } else if (state is TeacherSignUpFailure) {
          errordialog(context, state.errmessage).show();
        }
      },
      builder: (context, state) {
        return Custom_Loading_Widget(
          isLoading: state is TeacherSignUpLoading ? true : false,
          child: SingleChildScrollView(
            child: Form(
              key: Variables.TeacherSignUpFormKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: KHorizontalPadding,
                ),
                child: Column(
                  children: [
                    TeacherSignUPTextFieldsSection(
                        state: state,
                        onchanged: (value) {
                          radiovalue = value;
                          setState(() {});
                        },
                        width: width,
                        radiovalue: radiovalue),
                    const Customsizedbox(width: 0, height: 20),
                    Customtermsandconditiona(
                        textonpressed: () {},
                        onchanged: (value) {
                          isChecked = value;
                        }),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Custombutton(
                        text: "انشاء حساب",
                        color: KMainColor,
                        textColor: Colors.white,
                        onPressed: () {
                          if (Variables.TeacherSignUpFormKey.currentState!
                              .validate()) {
                            if (isChecked) {
                              BlocProvider.of<TeacherSignUpCubit>(context)
                                  .createUserWithEmailAndPassword(
                                      email: Variables
                                          .TeacherSignUpEmailController.text,
                                      password: Variables
                                          .TeacherSignUpPasswordController.text,
                                      name: Variables
                                          .TeacherSignUpFirstNameController
                                          .text);
                            } else {
                              errordialog(context,
                                      "يجب عليك الموافقة على الشروط والاحكام")
                                  .show();
                            }
                          }
                        }),
                    const Customsizedbox(width: 0, height: 20),
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).pop();
                      },
                      child: Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "لديك حساب بالفعل ؟ ",
                            style: AppTextStyles.semiBold16
                                .copyWith(color: const Color(0xff949D9E))),
                        TextSpan(
                            text: "تسجيل الدخول",
                            style: AppTextStyles.semiBold16
                                .copyWith(color: KMainColor))
                      ])),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

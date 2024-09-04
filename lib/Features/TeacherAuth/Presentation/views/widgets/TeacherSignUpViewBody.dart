import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Core/widgets/CustomTermsAndConditiona.dart';
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
    return SingleChildScrollView(
      child: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: KHorizontalPadding,
          ),
          child: Column(
            children: [
              TeacherSignUPTextFieldsSection(
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
                  onPressed: () {}),
              const Customsizedbox(width: 0, height: 20),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: "لديك حساب بالفعل ؟ ",
                    style: AppTextStyles.semiBold16
                        .copyWith(color: const Color(0xff949D9E))),
                TextSpan(
                    text: "تسجيل الدخول",
                    style: AppTextStyles.semiBold16.copyWith(color: KMainColor))
              ]))
            ],
          ),
        ),
      ),
    );
  }
}

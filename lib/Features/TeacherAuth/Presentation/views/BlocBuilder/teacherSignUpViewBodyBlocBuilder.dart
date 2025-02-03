// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Core/widgets/CustomTermsAndConditiona.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/manager/TeacherSignUP/teacher_sign_up_cubit.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/Sections/TeacherSignUPTextFieldsSection.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/teacherTermsAndConditionsView.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/widgets/TeacherSignUpViewBodyHaveAnAccountText.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/widgets/teacherSignUpViewBodyCustomButton.dart';
import 'package:sintir/constant.dart';

// ignore: must_be_immutable
class teacherSignUpViewBodyBlocBuilder extends StatefulWidget {
  const teacherSignUpViewBodyBlocBuilder({
    super.key,
    required this.state,
  });
  final TeacherSignUpState state;

  @override
  State<teacherSignUpViewBodyBlocBuilder> createState() =>
      _teacherSignUpViewBodyBlocBuilderState();
}

class _teacherSignUpViewBodyBlocBuilderState
    extends State<teacherSignUpViewBodyBlocBuilder> {
  String? radiovalue;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: Variables.TeacherSignUpFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: KHorizontalPadding, vertical: 24),
          child: Column(
            children: [
              TeacherSignUPTextFieldsSection(
                radiovalue: radiovalue,
                onchanged: (String? value) {
                  radiovalue = value;
                  setState(() {});
                },
              ),
              const Customsizedbox(width: 0, height: 20),
              Customtermsandconditiona(textonpressed: () {
                GoRouter.of(context)
                    .push(Teachertermsandconditionsview.routeName);
              }, onchanged: (value) {
                isChecked = value;
                setState(() {});
              }),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Custom_Loading_Widget(
                isLoading: widget.state is TeacherSignUpLoading ? true : false,
                child: teacherSignUpViewBodyCustomButton(
                  isChecked: isChecked,
                  radiovalue: radiovalue,
                  isPictureUploaded:
                      context.read<TeacherSignUpCubit>().imageFile != null
                          ? true
                          : false,
                ),
              ),
              const Customsizedbox(width: 0, height: 20),
              const TeacherSignUpViewBodyHaveAnAccountText()
            ],
          ),
        ),
      ),
    );
  }
}

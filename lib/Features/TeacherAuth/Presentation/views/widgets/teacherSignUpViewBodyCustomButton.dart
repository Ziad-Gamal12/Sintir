// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/manager/TeacherSignUP/teacher_sign_up_cubit.dart';
import 'package:sintir/constant.dart';

class teacherSignUpViewBodyCustomButton extends StatelessWidget {
  const teacherSignUpViewBodyCustomButton({
    super.key,
    required this.profilepictureUrl,
    required this.isChecked,
    required this.radiovalue,
  });

  final String? profilepictureUrl;
  final bool isChecked;
  final String? radiovalue;

  @override
  Widget build(BuildContext context) {
    return Custombutton(
        text: "انشاء حساب",
        color: KMainColor,
        textColor: Colors.white,
        onPressed: () {
          if (Variables.TeacherSignUpFormKey.currentState!.validate()) {
            if (profilepictureUrl != null) {
              if (isChecked) {
                BlocProvider.of<TeacherSignUpCubit>(context)
                    .createUserWithEmailAndPassword(
                        email: Variables.TeacherSignUpEmailController.text,
                        password:
                            Variables.TeacherSignUpPasswordController.text,
                        name:
                            "${Variables.TeacherSignUpFirstNameController.text} ${Variables.TeacherSignUpLastNameController.text}+${Variables.TeacherSignUpLastNameController.text}",
                        firstName:
                            Variables.TeacherSignUpFirstNameController.text,
                        lastName:
                            Variables.TeacherSignUpLastNameController.text,
                        address: Variables.TeacherSignUpAdressController.text,
                        phoneNumber:
                            Variables.TeacherSignUpPhoneNumberController.text,
                        subject: Variables.TeacherSignUpSubjectController.text,
                        workExperience: Variables
                            .TeacherSignUpWorkExperienceController.text,
                        gender: radiovalue ?? "ذكر",
                        profilePicurl: profilepictureUrl!,
                        state: BackendEndpoints.waiting);
              } else {
                errordialog(context, "يجب عليك الموافقة على الشروط والاحكام")
                    .show();
              }
            } else {
              errordialog(context, "يجب تحميل صورة مناسبة").show();
            }
          }
        });
  }
}

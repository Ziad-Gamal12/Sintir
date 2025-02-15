// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Entities/teacherEntity.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/manager/TeacherSignUP/teacher_sign_up_cubit.dart';
import 'package:sintir/constant.dart';

class teacherSignUpViewBodyCustomButton extends StatelessWidget {
  const teacherSignUpViewBodyCustomButton({
    super.key,
    required this.isChecked,
    required this.radiovalue,
    required this.isPictureUploaded,
  });

  final bool isChecked;
  final String? radiovalue;
  final bool isPictureUploaded;

  @override
  Widget build(BuildContext context) {
    return Custombutton(
        text: "انشاء حساب",
        color: KMainColor,
        textColor: Colors.white,
        onPressed: () {
          if (Variables.TeacherSignUpFormKey.currentState!.validate()) {
            if (isPictureUploaded) {
              if (isChecked) {
                BlocProvider.of<TeacherSignUpCubit>(context)
                    .createUserWithEmailAndPassword(
                  teacherentity: teacherEntity(
                      joinedDate: DateTime.now().toString(),
                      kind: "teacher",
                      socialLinks: [],
                      email: Variables.TeacherSignUpEmailController.text,
                      firstName:
                          Variables.TeacherSignUpFirstNameController.text,
                      lastName: Variables.TeacherSignUpLastNameController.text,
                      address: Variables.TeacherSignUpAdressController.text,
                      phoneNumber:
                          Variables.TeacherSignUpPhoneNumberController.text,
                      subject: Variables.TeacherSignUpSubjectController.text,
                      workExperience:
                          Variables.TeacherSignUpWorkExperienceController.text,
                      gender: radiovalue ?? "ذكر",
                      state: BackendEndpoints.waiting),
                  password: Variables.TeacherSignUpPasswordController.text,
                );
              } else {
                errordialog(context, "يجب عليك الموافقة على الشروط والاحكام")
                    .show();
              }
            } else {
              errordialog(context, "يجب رفع صورة الملف الشخصي").show();
            }
          }
        });
  }
}

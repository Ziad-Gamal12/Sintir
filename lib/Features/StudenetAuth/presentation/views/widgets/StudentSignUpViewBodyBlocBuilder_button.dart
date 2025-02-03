// ignore_for_file: camel_case_types, file_names

import 'package:dropdown_model_list/drop_down/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/StudenetAuth/domain/entities/studentEntity.dart';
import 'package:sintir/Features/StudenetAuth/presentation/manager/student_sign_up_cubit/student_sign_up_cubit.dart';
import 'package:sintir/constant.dart';

class StudentSignUpViewBodyBlocBuilder_button extends StatelessWidget {
  const StudentSignUpViewBodyBlocBuilder_button({
    super.key,
    required this.isTermsAndConditionChecked,
    required this.radioValue,
    required this.birthDayDate,
    required this.selectedItem,
    required this.stundentSignUpFormKey,
  });
  final GlobalKey<FormState> stundentSignUpFormKey;
  final bool isTermsAndConditionChecked;
  final String? radioValue;
  final DateTime? birthDayDate;
  final OptionItem? selectedItem;
  isstundetInformationValid(BuildContext context) {
    if (stundentSignUpFormKey.currentState!.validate()) {
      if (birthDayDate != null) {
        if (selectedItem != null) {
          if (isTermsAndConditionChecked) {
            BlocProvider.of<StudentSignUpCubit>(context)
                .createUserWithEmailAndPassword(
                    password: Variables.studentSignUpPasswordController.text,
                    studentEntity: Studententity(
                      kind: "student",
                      imageUrl: radioValue == "ذكر"
                          ? "https://cdn-icons-png.flaticon.com/128/2202/2202112.png"
                          : "https://cdn-icons-png.flaticon.com/128/6997/6997662.png",
                      firstName:
                          Variables.studentSignUpFirstNameController.text,
                      lastName: Variables.studentSignUpLastNameController.text,
                      email: Variables.studentSignUpEmailController.text,
                      phoneNumber:
                          Variables.studentSignUpPhoneNumberController.text,
                      gender: radioValue ?? "ذكر",
                      birthDate: birthDayDate!.toIso8601String(),
                      schoolName:
                          Variables.studentSignUpSchoolNameController.text,
                      educationLevel: selectedItem!.title,
                    ));
          } else {
            errordialog(context, "الرجاء أوافق على الشروط والاحكام").show();
          }
        } else {
          errordialog(context, "الرجاء تحديد المستوى التعليمي").show();
        }
      } else {
        errordialog(context, "الرجاء تحديد تاريخ الميلاد").show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Custombutton(
        text: "انشاء حساب",
        color: KMainColor,
        textColor: Colors.white,
        onPressed: () {
          isstundetInformationValid(context);
        });
  }
}

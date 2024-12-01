// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';

abstract class Variables {
  static GlobalKey<FormState> TeacherSignUpFormKey = GlobalKey<FormState>();
  static GlobalKey<FormState> StudnetSignUpFormKey = GlobalKey<FormState>();
  static ScrollController scrollController = ScrollController();
  static GlobalKey<FormState> TeacherLoginFormKey = GlobalKey<FormState>();
  static GlobalKey<FormState> TeacherResetPasswordFormKey =
      GlobalKey<FormState>();
  static GlobalKey<ScaffoldState> HomeViewScaffoldKey =
      GlobalKey<ScaffoldState>();
  static GlobalKey<ScaffoldState> DisplaycoursevedioveiwScaffoldKey =
      GlobalKey<ScaffoldState>();
  static TextEditingController TeacherSignUpFirstNameController =
      TextEditingController();
  static TextEditingController TeacherSignUpLastNameController =
      TextEditingController();
  static TextEditingController TeacherSignUpEmailController =
      TextEditingController();
  static TextEditingController TeacherSignUpPasswordController =
      TextEditingController();
  static TextEditingController TeacherSignUpAdressController =
      TextEditingController();
  static TextEditingController TeacherSignUpPhoneNumberController =
      TextEditingController();
  static TextEditingController TeacherSignUpSubjectController =
      TextEditingController();
  static TextEditingController TeacherSignUpWorkExperienceController =
      TextEditingController();
  static TextEditingController TeacherLoginEmailController =
      TextEditingController();
  static TextEditingController TeacherLoginPasswordController =
      TextEditingController();
  static TextEditingController StudentSigninEmailController =
      TextEditingController();
  static TextEditingController StudentSigninPasswordController =
      TextEditingController();
  static TextEditingController ResetPasswordController =
      TextEditingController();
  static TextEditingController studentSignUpEmailController =
      TextEditingController();
  static TextEditingController studentSignUpFirstNameController =
      TextEditingController();
  static TextEditingController studentSignUpLastNameController =
      TextEditingController();
  static TextEditingController studentSignUpBirthDateController =
      TextEditingController();
  static TextEditingController studentSignUpEducationLevelController =
      TextEditingController();
  static TextEditingController studentSignUpSchoolNameController =
      TextEditingController();
  static TextEditingController studentSignUpPasswordController =
      TextEditingController();

  static TextEditingController studentSignUpPhoneNumberController =
      TextEditingController();
}

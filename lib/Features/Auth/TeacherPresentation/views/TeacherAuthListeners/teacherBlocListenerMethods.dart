import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/manager/TeacherSignUP/teacher_sign_up_cubit.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/manager/teacher_sign_in/teacher_sign_in_cubit.dart';
import 'package:sintir/Features/Home/presentation/views/HomeView.dart';

void teacherSignInBlocListener(context, state) {
  if (state is TeacherSignInSuccess) {
    GoRouter.of(context).pushReplacement(Homeview.routeName);
  } else if (state is TeacherSignInFailure) {
    errordialog(context, state.errmessage).show();
  }
}

void teacherSignUpListener(context, TeacherSignUpState state) {
  if (state is TeacherSignUpSuccess) {
    successdialog(
        context: context,
        SuccessMessage: "سيتم مراجعة طلبك للأنضام لهيئة المعلمبن في اقرب وقت!",
        btnOkOnPress: () {
          GoRouter.of(context).pop();
        }).show();
  } else if (state is TeacherSignUpFailure) {
    errordialog(context, state.errmessage).show();
  }
}

void teacherSignUpViewBodyUplaodPicListener(
  TeacherSignUpState state,
  BuildContext context,
) {
  if (state is PickTeacherProfilePicSuccess) {
    CustomSnackBar.show(
      context,
      message: "تم رفع الصورة بنجاح",
      type: SnackType.success,
    );
  }
}

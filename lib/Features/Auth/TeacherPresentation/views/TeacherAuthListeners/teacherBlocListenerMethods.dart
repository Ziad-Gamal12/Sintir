import 'package:go_router/go_router.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/manager/TeacherSignUP/teacher_sign_up_cubit.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/manager/teacher_sign_in/teacher_sign_in_cubit.dart';
import 'package:sintir/Features/Home/presentation/views/HomeView.dart';
import 'package:sintir/locale_keys.dart';

void teacherSignInBlocListener(context, state) {
  if (state is TeacherSignInSuccess) {
    GoRouter.of(context).go(Homeview.routeName);
  } else if (state is TeacherSignInFailure) {
    errordialog(context, state.errmessage).show();
  }
}

void teacherSignUpListener(context, TeacherSignUpState state) {
  if (state is TeacherSignUpSuccess) {
    successdialog(
        context: context,
        SuccessMessage: LocaleKeys.teacherRequestReview,
        btnOkOnPress: () {
          GoRouter.of(context).pop();
        }).show();
  } else if (state is TeacherSignUpFailure) {
    errordialog(context, state.errmessage).show();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Core/widgets/CustomTeaxtField.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/manager/teacherResetPassword/teacher_reset_password_cubit.dart';
import 'package:sintir/constant.dart';

class teacherResetPasswordViewBodyBlocBuilder extends StatelessWidget {
  const teacherResetPasswordViewBodyBlocBuilder({
    super.key,
    required this.state,
  });
  final TeacherResetPasswordState state;
  @override
  Widget build(BuildContext context) {
    return Custom_Loading_Widget(
      isLoading: state is TeacherResetPasswordLoading ? true : false,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: KHorizontalPadding, vertical: KVerticalPadding),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                "إذا كنت قد نسيت كلمة المرور الخاصة بك، لا داعي للقلق. نحن هنا لمساعدتك! يرجى إدخال عنوان بريدك الإلكتروني المسجل في الحقل أدناه. بعد ذلك، سنرسل لك رسالة تحتوي على تعليمات مفصلة لإعادة تعيين كلمة المرور الخاصة بك. تأكد من التحقق من صندوق الوارد والبريد غير الهام (سبام) الخاص بك. إذا لم تصلك الرسالة خلال بضع دقائق، يمكنك إعادة المحاولة.",
                style:
                    AppTextStyles.semiBold13Auto.copyWith(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            const Customsizedbox(width: 0, height: 20),
            Customteaxtfield(
                hintText: "البريد الإلكتروني",
                prefixIcon: Icons.email,
                obscureText: false,
                controller: Variables.ResetPasswordController,
                textInputType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "ادخل البريد الإلكتروني";
                  } else if (!value.contains("@")) {
                    return "ادخل البريد الإلكتروني صحيح";
                  } else {
                    return null;
                  }
                }),
            const Customsizedbox(width: 0, height: 20),
            Custombutton(
                text: "نسيت كلمة المرور",
                color: KMainColor,
                textColor: Colors.white,
                onPressed: () {
                  context
                      .read<TeacherResetPasswordCubit>()
                      .sendResetPasswordEmail(
                          email: Variables.ResetPasswordController.text);
                }),
            const Spacer(),
            Text(
              "تسجيل الدخول؟",
              style: AppTextStyles.semiBold16.copyWith(color: KMainColor),
            ),
          ],
        ),
      ),
    );
  }
}

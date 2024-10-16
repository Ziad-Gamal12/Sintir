import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/CustomLoginViewBodyDonotHaveAccountText.dart';
import 'package:sintir/Core/widgets/CustomSepratedWidget.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/widgets/Student_SigninSocialbuttonssection.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/widgets/student_SigninTextfiledsection.dart';
import 'package:sintir/constant.dart';

class StudentSignInViewBody extends StatefulWidget {
  const StudentSignInViewBody({super.key});

  @override
  State<StudentSignInViewBody> createState() => _StudentSignInViewBodyState();
}

class _StudentSignInViewBodyState extends State<StudentSignInViewBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Customsizedbox(width: 0, height: 12),
            const student_SigninTextfiledsection(),
            const Customsizedbox(width: 0, height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "نسيت كلمة المرور؟",
                  style:
                      AppTextStyles.semiBold13Auto.copyWith(color: KMainColor),
                )
              ],
            ),
            const Customsizedbox(width: 0, height: 30),
            Custombutton(
                text: "تسجيل الدخول",
                color: KMainColor,
                textColor: Colors.white,
                onPressed: () {}),
            const Customsizedbox(width: 0, height: 30),
            CustomLoginViewBodyDonotHaveAccountText(onTap: () {}),
            const Customsizedbox(width: 0, height: 55),
            const Customsepratedwidget(
              centerTitle: "او",
            ),
            const Customsizedbox(width: 0, height: 30),
            const Student_SigninSocialbuttonssection()
          ],
        ),
      ),
    );
  }
}

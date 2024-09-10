import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Features/StudentOnboarding/Presentation/Views/widgets/CustomAppBar.dart';
import 'package:sintir/constant.dart';

import '../../../../Core/utils/Variables.dart';
import '../../../../Core/utils/textStyles.dart';
import '../../../../Core/widgets/CustomTeaxtField.dart';

class ResetPasswordPage extends StatelessWidget {
  static const String routeName = "/ResetPasswordPage";
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ResetPasswordBody(),
    );
  }
}

class ResetPasswordBody extends StatelessWidget {
  const ResetPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(
          title: 'استعاده كلمة المرور',
        ),
        const SizedBox(
          height: 28,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
          child: Text(
            'إذا كنت قد نسيت كلمة المرور الخاصة بك، لا داعي للقلق. نحن هنا لمساعدتك! يرجى إدخال عنوان بريدك الإلكتروني المسجل في الحقل أدناه. بعد ذلك، سنرسل لك رسالة تحتوي على تعليمات مفصلة لإعادة تعيين كلمة المرور الخاصة بك. تأكد من التحقق من صندوق الوارد والبريد غير الهام (سبام) الخاص بك. إذا لم تصلك الرسالة خلال بضع دقائق، يمكنك إعادة المحاولة.',
            style: AppTextStyles.bold13
                .copyWith(color: const Color(0xff818181).withOpacity(.70)),
          ),
        ),
        const Customsizedbox(
          width: 0,
          height: 31,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
          child: Customteaxtfield(
            controller: Variables.StudentSigninEmailController,
            hintText: 'البريد الالكتروني',
            prefixIcon: Icons.email,
            obscureText: false,
            textInputType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'يرجي ادخال البريد الالكتروني';
              }
              return null;
            },
          ),
        ),
        const Customsizedbox(width: 0, height: 35),
        Padding(
          padding: const EdgeInsets.only(right: 15, left: 17),
          child: Custombutton(
              text: 'نسيت كلمة المرور',
              color: const Color(0xff4169E2),
              textColor: Colors.white,
              onPressed: () {}),
        ),
        const Expanded(
          child: SizedBox(
            height: 295,
          ),
        ),
        Padding(
          //background: #;
          padding: const EdgeInsets.only(left: 97, right: 97, bottom: 30),
          child: Text(
            'تسجيل الدخول؟',
            style: AppTextStyles.bold16Auto
                .copyWith(color: const Color(0xff4169E2)),
          ),
        )
      ],
    );
  }
}

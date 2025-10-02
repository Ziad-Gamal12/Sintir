import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomResetPasswordViewBodyDescription extends StatelessWidget {
  const CustomResetPasswordViewBodyDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        "إذا كنت قد نسيت كلمة المرور الخاصة بك، لا داعي للقلق. نحن هنا لمساعدتك! يرجى إدخال عنوان بريدك الإلكتروني المسجل في الحقل أدناه. بعد ذلك، سنرسل لك رسالة تحتوي على تعليمات مفصلة لإعادة تعيين كلمة المرور الخاصة بك. تأكد من التحقق من صندوق الوارد والبريد غير الهام (سبام) الخاص بك. إذا لم تصلك الرسالة خلال بضع دقائق، يمكنك إعادة المحاولة.",
        style: AppTextStyles(context).semiBold13.copyWith(color: Colors.grey),
        textAlign: TextAlign.justify,
      ),
    );
  }
}

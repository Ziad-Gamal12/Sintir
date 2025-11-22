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
        "أدخل بريدك الإلكتروني وسنرسل لك رابطًا لإعادة تعيين كلمة المرور الخاصة بك.",
        style:
            AppTextStyles(context).semiBold14.copyWith(color: Colors.black54),
        textAlign: TextAlign.center,
      ),
    );
  }
}

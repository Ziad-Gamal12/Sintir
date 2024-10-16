import 'package:flutter/material.dart';

class Section5AccountTermination extends StatelessWidget {
  const Section5AccountTermination({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      '''
      5. إنهاء الحساب:
      - يحتفظ تطبيق سنتر بالحق في إنهاء حساب المعلم في حالة انتهاك أي من هذه الشروط والأحكام.
      - يمكن للمعلم إلغاء حسابه في أي وقت، على أن يتم الالتزام بإتمام جميع الالتزامات الحالية تجاه الطلاب.
      ''',
      style: TextStyle(fontSize: 16),
    );
  }
}

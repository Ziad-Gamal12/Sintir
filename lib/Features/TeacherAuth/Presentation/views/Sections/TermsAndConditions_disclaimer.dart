import 'package:flutter/material.dart';

class Section7Disclaimer extends StatelessWidget {
  const Section7Disclaimer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      '''
      7. إخلاء المسؤولية:
      - سنتر غير مسؤول عن أي أخطاء أو خسائر قد تنجم عن استخدام المحتوى المقدم من قبل المعلمين.
      - المعلمون يتحملون المسؤولية الكاملة عن المحتوى الذي يقومون بنشره.
      ''',
      style: TextStyle(fontSize: 16),
    );
  }
}

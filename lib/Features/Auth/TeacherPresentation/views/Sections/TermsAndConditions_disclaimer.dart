// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Section7Disclaimer extends StatelessWidget {
  const Section7Disclaimer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      '7. إخلاء المسؤولية:\n سنتر غير مسؤول عن أي أخطاء أو خسائر قد تنجم عن استخدام المحتوى المقدم من قبل المعلمين.\n المعلمون يتحملون المسؤولية الكاملة عن المحتوى الذي يقومون بنشره.',
      style: TextStyle(fontSize: 16),
      textAlign: TextAlign.right,
    );
  }
}

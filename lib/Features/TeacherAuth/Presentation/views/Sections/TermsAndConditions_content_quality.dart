import 'package:flutter/material.dart';

class Section2ContentQuality extends StatelessWidget {
  const Section2ContentQuality({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      '''
      2. جودة المحتوى:
      - يُتوقع من المعلمين تقديم محتوى تعليمي عالي الجودة ودقيق.
      - يجب أن يكون المحتوى مُعدًا بطريقة احترافية وأن يلبي احتياجات الطلاب.
      ''',
      style: TextStyle(fontSize: 16),
    );
  }
}

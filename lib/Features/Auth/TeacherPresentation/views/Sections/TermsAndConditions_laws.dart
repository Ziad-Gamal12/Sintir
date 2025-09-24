// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Section1Laws extends StatelessWidget {
  const Section1Laws({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      '1. الالتزام بالقوانين-\n  يجب على المعلمين الالتزام بجميع القوانين واللوائح المحلية والوطنية المعمول بها في تقديم المحتوى التعليمي.\nلا يُسمح بنشر أي محتوى غير قانوني أو مسيء أو ينتهك حقوق الملكية الفكرية للآخرين.',
      style: TextStyle(fontSize: 16),
      textAlign: TextAlign.right,
    );
  }
}

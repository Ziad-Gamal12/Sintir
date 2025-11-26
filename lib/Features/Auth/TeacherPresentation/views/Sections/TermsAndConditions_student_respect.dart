// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/locale_keys.dart';

class Section3StudentRespect extends StatelessWidget {
  const Section3StudentRespect({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      LocaleKeys.term3,
      style: const TextStyle(fontSize: 16),
      textAlign: TextAlign.start,
    );
  }
}

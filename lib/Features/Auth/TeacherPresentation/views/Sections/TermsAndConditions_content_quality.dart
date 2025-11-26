// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/locale_keys.dart';

class Section2ContentQuality extends StatelessWidget {
  const Section2ContentQuality({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      LocaleKeys.term2,
      style: const TextStyle(fontSize: 16),
      textAlign: TextAlign.start,
    );
  }
}

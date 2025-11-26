// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/locale_keys.dart';

class Section6Updates extends StatelessWidget {
  const Section6Updates({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      LocaleKeys.term6,
      style: const TextStyle(fontSize: 16),
      textAlign: TextAlign.start,
    );
  }
}

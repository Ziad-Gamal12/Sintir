// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/locale_keys.dart';

class Section1Laws extends StatelessWidget {
  const Section1Laws({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      LocaleKeys.term1,
      style: const TextStyle(fontSize: 16),
      textAlign: TextAlign.start,
    );
  }
}

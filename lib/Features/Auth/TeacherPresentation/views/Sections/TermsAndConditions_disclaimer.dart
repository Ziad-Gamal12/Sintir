// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/locale_keys.dart';

class Section7Disclaimer extends StatelessWidget {
  const Section7Disclaimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      LocaleKeys.term7,
      style: const TextStyle(fontSize: 16),
      textAlign: TextAlign.start,
    );
  }
}

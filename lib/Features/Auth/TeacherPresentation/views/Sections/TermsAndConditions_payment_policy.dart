// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/locale_keys.dart';

class Section4PaymentPolicy extends StatelessWidget {
  const Section4PaymentPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      LocaleKeys.term4,
      style: const TextStyle(fontSize: 16),
      textAlign: TextAlign.start,
    );
  }
}

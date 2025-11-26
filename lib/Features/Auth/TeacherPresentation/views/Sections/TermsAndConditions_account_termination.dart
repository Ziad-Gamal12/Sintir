// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/locale_keys.dart';

class Section5AccountTermination extends StatelessWidget {
  const Section5AccountTermination({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      LocaleKeys.term5,
      style: const TextStyle(fontSize: 16),
      textAlign: TextAlign.start,
    );
  }
}

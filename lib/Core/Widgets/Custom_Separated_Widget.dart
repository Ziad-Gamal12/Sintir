// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';

class customSeparatedWidget extends StatelessWidget {
  const customSeparatedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: const Color(0xffDDDFDF),
      height: 1.5,
      width: width * .35,
    );
  }
}

// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Features/ChoosingState/Presentation/views/widgets/ChoosingstateviewBody.dart';

class Choosingstateview extends StatelessWidget {
  const Choosingstateview({super.key});
  static const routeName = '/Choosingstateview';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ChoosingstateviewBody(),
    );
  }
}

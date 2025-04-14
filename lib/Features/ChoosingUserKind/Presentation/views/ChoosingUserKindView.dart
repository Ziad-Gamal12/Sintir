// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Features/ChoosingUserKind/Presentation/views/widgets/ChoosingUserKindBody.dart';

class ChoosingUserKindView extends StatelessWidget {
  const ChoosingUserKindView({super.key});
  static const routeName = '/ChoosingUserKindView';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: ChoosingUserKindBody()),
    );
  }
}

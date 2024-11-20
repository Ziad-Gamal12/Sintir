import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/AI_Chat/presentation/views/widgets/AichatviewBody.dart';

class Aichatview extends StatelessWidget {
  const Aichatview({super.key});
  static const routeName = '/Aichatview';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBartitle: "المساعد الألى"),
      body: SafeArea(
        child: AichatviewBody(),
      ),
    );
  }
}

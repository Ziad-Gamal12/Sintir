import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/CoursetestviewBody.dart';

class Coursetestview extends StatelessWidget {
  const Coursetestview({super.key});
  static const routename = "/Coursetestview";
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(appBartitle: "أسئلة متعلقة بالدرس"),
      body: CoursetestviewBody(),
    );
  }
}

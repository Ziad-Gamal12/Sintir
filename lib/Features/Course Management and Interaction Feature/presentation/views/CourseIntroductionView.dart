import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseIntroduction_Widgets/CourseIntroductionViewBody.dart';

class CourseIntroductionView extends StatelessWidget {
  const CourseIntroductionView({super.key});
  static const routeName = "/CourseIntroductionView";
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(appBartitle: "Creatives X Event Vol.2"),
      body: CourseIntroductionViewBody(),
    );
  }
}

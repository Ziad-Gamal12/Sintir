import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CoursedetailsviewBody.dart';

class Coursedetailsview extends StatelessWidget {
  const Coursedetailsview({super.key});
  static const routeName = "/coursedetailsview";
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(appBartitle: "Creatives X Event Vol.2"),
      body: CoursedetailsviewBody(),
    );
  }
}

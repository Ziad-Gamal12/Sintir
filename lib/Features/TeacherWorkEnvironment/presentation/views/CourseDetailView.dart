import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CoursedetailviewBody.dart';

class Coursedetailview extends StatelessWidget {
  const Coursedetailview({super.key, required this.courseEntity});
  static String routeName = "/Coursedetailview";
  final CourseEntity courseEntity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(appBartitle: "تفاصيل الدورة"),
        body: CoursedetailviewBody(
          courseEntity: courseEntity,
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseFIlePreViewer_Widgets/CoursefilepreviewerViewBody.dart';

class CoursefilepreviewerView extends StatelessWidget {
  const CoursefilepreviewerView({super.key, required this.coursefileentity});
  static const routename = "/CoursefilepreviewerView";
  final Coursefileentity coursefileentity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBartitle: coursefileentity.title),
      body: Coursefilepreviewerviewbody(
        file: coursefileentity,
      ),
    );
  }
}

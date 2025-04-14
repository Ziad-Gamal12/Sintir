import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileviewnavigationsrequirmentsentity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseFIlePreViewer_Widgets/CoursefilepreviewerViewBody.dart';

class CoursefilepreviewerView extends StatelessWidget {
  const CoursefilepreviewerView(
      {super.key, required this.coursefileviewnavigationsrequirmentsentity});
  static const routename = "/CoursefilepreviewerView";
  final Coursefileviewnavigationsrequirmentsentity
      coursefileviewnavigationsrequirmentsentity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          appBartitle: coursefileviewnavigationsrequirmentsentity.file.title),
      body: Coursefilepreviewerviewbody(
        file: coursefileviewnavigationsrequirmentsentity.file,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseViewWidgets/AddCoursePoster.dart';

class EditCoursePoster extends StatelessWidget {
  EditCoursePoster({super.key, required this.coursePosterUrl});
  String coursePosterUrl;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Addcourseposter(
        coursePosterUrl: coursePosterUrl,
        onTap: () {},
      ),
    );
  }
}

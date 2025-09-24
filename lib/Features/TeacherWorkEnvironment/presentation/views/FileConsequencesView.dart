import 'package:flutter/material.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/FileConsequencesViewWidgets/FileConsequencesViewBody.dart';

class FileConsequencesView extends StatelessWidget {
  const FileConsequencesView({super.key, required this.file});
  final CourseFileEntity file;
  static const routeName = '/FileConsequencesView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("التقارير الخاصة بالملف")),
        body: FileConsequencesViewBody(file: file));
  }
}

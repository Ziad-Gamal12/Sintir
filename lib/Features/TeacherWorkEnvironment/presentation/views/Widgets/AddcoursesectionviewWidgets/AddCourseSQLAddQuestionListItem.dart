import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddcoursesectionviewWidgets/AddCourseSQLAddQuestionImage.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddcoursesectionviewWidgets/SQLTestQuestionInputs.dart';

class Addcoursesqladdquestionlistitem extends StatefulWidget {
  const Addcoursesqladdquestionlistitem({
    super.key,
    required this.coursetestquestionentity,
  });
  final Coursetestquestionentity coursetestquestionentity;
  @override
  State<Addcoursesqladdquestionlistitem> createState() =>
      _AddcoursesqladdquestionlistitemState();
}

class _AddcoursesqladdquestionlistitemState
    extends State<Addcoursesqladdquestionlistitem> {
  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: widget.coursetestquestionentity,
      child: const Column(
        children: [
          SQLTestQuestionInputs(),
          SizedBox(
            height: 5,
          ),
          Addcoursesqladdquestionimage()
        ],
      ),
    );
  }
}

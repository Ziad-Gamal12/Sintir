import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/AddCourseSectionView.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class CustomAddNewCourseSectionButton extends StatelessWidget {
  const CustomAddNewCourseSectionButton({
    super.key,
    required this.course,
  });

  final CourseEntity course;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context)
            .push(Addcoursesectionview.routeName, extra: course);
      },
      child: Tooltip(
        message: LocaleKeys.addLecture,
        child: const CircleAvatar(
          backgroundColor: KMainColor,
          radius: 35,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/TeacherWorkenvironmentview.dart';
import 'package:sintir/constant.dart';

class WorkEnvironmentNavigationButton extends StatelessWidget {
  const WorkEnvironmentNavigationButton(
      {super.key, required this.role, required this.myCourses});
  final String role;
  final List<CourseEntity> myCourses;
  @override
  Widget build(BuildContext context) {
    if (role == BackendEndpoints.teacherRole) {
      return Custombutton(
          text: "الذهاب لبيئة العمل",
          color: KMainColor,
          textColor: Colors.white,
          onPressed: () {
            GoRouter.of(context)
                .push(TeacherWorkenvironmentview.routeName, extra: myCourses);
          });
    } else {
      return const SizedBox();
    }
  }
}

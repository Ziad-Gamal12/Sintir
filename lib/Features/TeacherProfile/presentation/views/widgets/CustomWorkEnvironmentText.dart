import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Managers/Cubits/user_cubit/user_cubit.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Entities/teacherEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/TeacherWorkenvironmentview.dart';
import 'package:sintir/constant.dart';

class CustomWorkEnvironmentText extends StatelessWidget {
  const CustomWorkEnvironmentText({
    super.key,
    required this.myCourses,
  });
  final List<CourseEntity> myCourses;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).push(TeacherWorkenvironmentview.routeName,
            extra: getMyCreatedCourses(context: context));
      },
      child: Row(
        children: [
          Text(
            "بيئة العمل",
            style: AppTextStyles.semiBold14.copyWith(color: KMainColor),
          ),
          const SizedBox(
            width: 5,
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 15,
            color: KMainColor,
          ),
        ],
      ),
    );
  }

/*************  ✨ Windsurf Command ⭐  *************/
  /// This function takes a list of courses and a buildContext as parameters,
  /// and returns a new list containing only the courses that the teacher
  /// who is currently logged in has created. The teacher is retrieved from
  /// the context using the UserCubit. The function iterates over the list
  /// of courses and checks if the course's content creator id matches the
  /// teacher's uid. If it does, the course is added to the new list. The
  /// function then returns the new list.
  ///
  /// [context] is the buildContext of the widget that calls this function.
  ///
  /// [myCourses] is the list of courses to be filtered.
  ///
  /// The function returns a list of CourseEntity objects that the teacher
  /// has created.
  /// *****  e6bba588-397b-4dab-a8d0-232e32cbb1fb  ******

  List<CourseEntity> getMyCreatedCourses({required BuildContext context}) {
    List<CourseEntity> myCreatedCourses = [];
    teacherEntity teacher = context.read<UserCubit>().teacherentity!;
    for (var course in myCourses) {
      if (course.contentcreaterentity!.id == teacher.uid) {
        myCreatedCourses.add(course);
      }
    }
    return myCreatedCourses;
  }
}

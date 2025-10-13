import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/AddCourseCouponWidgets/AddCourseCouponView.dart';
import 'package:sintir/constant.dart';

class CourseDetailsCouponsViewFloatingButton extends StatelessWidget {
  const CourseDetailsCouponsViewFloatingButton({
    super.key,
    required this.courseId,
  });

  final String courseId;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: KMainColor,
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 30,
      ),
      onPressed: () {
        GoRouter.of(context)
            .push(AddCourseCouponView.routeName, extra: courseId);
      },
    );
  }
}

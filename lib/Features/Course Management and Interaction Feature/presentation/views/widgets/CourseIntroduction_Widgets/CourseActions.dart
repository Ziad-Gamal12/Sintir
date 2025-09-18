import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/widgets/InfoRow.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/CourseFedBackView.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/SendCourseReportView.dart';

class CourseActions extends StatelessWidget {
  final DisplayCourseBottomsheetNavigationRequirmentsEntity requirmentsEntity;
  const CourseActions(this.requirmentsEntity, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            GoRouter.of(context)
                .push(Sendcoursereportview.routeName, extra: requirmentsEntity);
          },
          child: const InfoRow(
            icon: FontAwesomeIcons.circleExclamation,
            label: "تقديم ابلاغ",
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            GoRouter.of(context)
                .push(Coursefedbackview.routeName, extra: requirmentsEntity);
          },
          child: const InfoRow(
            icon: FontAwesomeIcons.comment,
            label: "أراء طلاب أخرين",
          ),
        ),
      ],
    );
  }
}

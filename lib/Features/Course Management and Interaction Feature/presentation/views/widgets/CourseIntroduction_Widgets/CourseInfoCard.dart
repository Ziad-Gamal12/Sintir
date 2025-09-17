import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseIntroduction_Widgets/CoursIntroductionviewbodydescription.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseIntroduction_Widgets/CourseActions.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseIntroduction_Widgets/CourseMetaInfo.dart';

class CourseInfoCard extends StatefulWidget {
  final DisplayCourseBottomsheetNavigationRequirmentsEntity requirmentsEntity;
  const CourseInfoCard({super.key, required this.requirmentsEntity});

  @override
  State<CourseInfoCard> createState() => _CourseInfoCardState();
}

class _CourseInfoCardState extends State<CourseInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4)),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 2, child: CourseMetaInfo(widget.requirmentsEntity)),
              const Spacer(flex: 1),
              Expanded(flex: 2, child: CourseActions(widget.requirmentsEntity)),
            ],
          ),
          const CourseInfoCardCourseDescription(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

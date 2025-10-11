import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseInfoSectionWidgets/custom_course_details_body_course_info_card.dart';

class CustomCourseDetailsBodyCourseInfo extends StatelessWidget {
  const CustomCourseDetailsBodyCourseInfo({
    super.key,
    required this.courseEntity,
  });

  final CourseEntity courseEntity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: CustomCachedNetworkImage(
                imageUrl: courseEntity.posterUrl!,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: -MediaQuery.of(context).size.width * .2,
              right: 20,
              left: 20,
              child: CustomCourseDetailsBodyCourseInfoCard(
                  courseEntity: courseEntity),
            ),
          ],
        ),
      ),
    );
  }
}

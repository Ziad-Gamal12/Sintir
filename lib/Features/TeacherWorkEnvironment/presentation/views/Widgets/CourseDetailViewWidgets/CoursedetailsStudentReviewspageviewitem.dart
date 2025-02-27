import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursefedbackItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/Coursedetailsstudentreviewslistview.dart';

class Coursedetailsstudentreviewspageviewitem extends StatelessWidget {
  const Coursedetailsstudentreviewspageviewitem(
      {super.key, required this.reviews});
  final List<CoursefedbackItemEntity> reviews;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        reviews.isEmpty
            ? const CustomEmptyWidget()
            : Coursedetailsstudentreviewslistview(
                reviews: reviews,
              )
      ],
    );
  }
}

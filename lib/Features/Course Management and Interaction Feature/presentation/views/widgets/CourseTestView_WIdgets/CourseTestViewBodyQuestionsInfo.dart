import 'package:flutter/material.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/courseTestViewBodyDetailsItem.dart';

class CourseTestViewBodyQuestionsInfo extends StatelessWidget {
  const CourseTestViewBodyQuestionsInfo({
    super.key,
    required this.coursetestentity,
  });

  final Coursetestentity coursetestentity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Coursetestviewbodydetailsitem(
            title: "عدد الأسئلة الكلى",
            count: coursetestentity.questions.length.toString(),
            countColor: Colors.grey.shade400,
            countTextColor: Colors.black),
        const SizedBox(
          height: 10,
        ),
        Coursetestviewbodydetailsitem(
            title: "عدد الأسئلة التى تم حلها ",
            count: coursetestentity.questions.length.toString(),
            countColor: Colors.green,
            countTextColor: Colors.white),
        const SizedBox(
          height: 10,
        ),
        Coursetestviewbodydetailsitem(
            title: "عدد الأسئلة التى  لم يتم حلها ",
            count: coursetestentity.questions.length.toString(),
            countColor: Colors.red,
            countTextColor: Colors.white),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseDetailsSubscribersGridviewItemAddress.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseDetailsSubscribersGridviewItemAvatar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseDetailsSubscribersGridviewItemPhoneNumber.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseDetailsSubscribersGridviewItemSchoolLevel.dart';

class CourseDetailsSubscribersGridviewItem extends StatelessWidget {
  const CourseDetailsSubscribersGridviewItem(
      {super.key, required this.subscriberentity});
  final SubscriberEntity subscriberentity;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 7,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.grey.shade300, width: .5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CourseDetailsSubscribersGridviewItemAvatar(
              imageUrl: subscriberentity.imageUrl),
          const SizedBox(
            height: 10,
          ),
          Text(
            subscriberentity.name,
            style: AppTextStyles(context).semiBold20,
          ),
          const Spacer(),
          CourseDetailsSubscribersGridviewItemPhoneNumber(
              phone: subscriberentity.phone),
          const SizedBox(
            height: 5,
          ),
          CourseDetailsSubscribersGridviewItemSchoolLevel(
              schoolLevel: subscriberentity.educationLevel),
          const SizedBox(
            height: 5,
          ),
          CourseDetailsSubscribersGridviewItemAddress(
              address: subscriberentity.address),
        ],
      ),
    );
  }
}

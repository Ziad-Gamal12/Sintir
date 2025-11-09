import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/CustomSubscriberDetailsCardAvatar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/CustomSubscriberDetailsCardInformation.dart';

class CustomSubscriberDetailsCard extends StatelessWidget {
  const CustomSubscriberDetailsCard(
      {super.key, required this.subscriberentity});
  final SubscriberEntity subscriberentity;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: CustomSubscriberDetailsCardAvatar(
                    imageUrl: subscriberentity.imageUrl),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 3,
                child: CustomSubscriberDetailsCardInformation(
                    subscriberentity: subscriberentity),
              ),
            ],
          )),
    );
  }
}

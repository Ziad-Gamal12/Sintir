import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseDetailsSubscribersGridviewItemAddress.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseDetailsSubscribersGridviewItemAvatar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseDetailsSubscribersGridviewItemPhoneNumber.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseDetailsSubscribersGridviewItemSchoolLevel.dart';

class CourseDetailsSubscribersGridviewItem extends StatelessWidget {
  const CourseDetailsSubscribersGridviewItem(
      {super.key, required this.subscriber});
  final SubscriberEntity subscriber;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color cardColor = theme.cardColor;
    final Color borderColor = theme.dividerColor;
    final Color primaryTextColor = theme.textTheme.bodyLarge!.color!;
    final bool isDarkMode = theme.brightness == Brightness.dark;

    // Adjusted shadow for theme compatibility
    final List<BoxShadow> boxShadows = isDarkMode
        ? [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 7,
              spreadRadius: 1,
              offset: const Offset(0, 3),
            ),
          ]
        : [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 7,
              spreadRadius: 1,
              offset: const Offset(0, 3),
            ),
          ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: boxShadows,
        border: Border.all(color: borderColor.withOpacity(0.5), width: .5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CourseDetailsSubscribersGridviewItemAvatar(
              imageUrl: subscriber.imageUrl),
          const SizedBox(
            height: 10,
          ),
          Text(
            subscriber.name,
            style: AppTextStyles(context)
                .semiBold20
                .copyWith(color: primaryTextColor),
          ),
          const Spacer(),
          CourseDetailsSubscribersGridviewItemPhoneNumber(
              phone: subscriber.phone),
          const SizedBox(
            height: 5,
          ),
          CourseDetailsSubscribersGridviewItemSchoolLevel(
              schoolLevel: subscriber.educationLevel),
          const SizedBox(
            height: 5,
          ),
          CourseDetailsSubscribersGridviewItemAddress(
              address: subscriber.address),
        ],
      ),
    );
  }
}

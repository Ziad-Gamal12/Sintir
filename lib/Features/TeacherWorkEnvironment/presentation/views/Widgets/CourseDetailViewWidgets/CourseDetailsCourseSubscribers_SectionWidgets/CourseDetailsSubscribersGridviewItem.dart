import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseDetailsSubscribersGridviewItemAddress.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseDetailsSubscribersGridviewItemAvatar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseDetailsSubscribersGridviewItemPhoneNumber.dart';

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

    final List<BoxShadow> boxShadows = isDarkMode
        ? [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.4),
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
        border:
            Border.all(color: borderColor.withValues(alpha: 0.5), width: .5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 90,
            width: 90,
            child: CourseDetailsSubscribersGridviewItemAvatar(
                imageUrl: subscriber.imageUrl),
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  subscriber.name,
                  style: AppTextStyles(context)
                      .semiBold16
                      .copyWith(color: primaryTextColor),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 12,
                ),
                CourseDetailsSubscribersGridviewItemPhoneNumber(
                    phone: subscriber.phone),
                const SizedBox(
                  height: 8,
                ),
                CourseDetailsSubscribersGridviewItemAddress(
                    address: subscriber.address),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

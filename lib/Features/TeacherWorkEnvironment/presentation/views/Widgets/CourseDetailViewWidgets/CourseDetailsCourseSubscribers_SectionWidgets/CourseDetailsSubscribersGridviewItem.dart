import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomPhoneIwidget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseDetailsSubscribersGridviewItemAddress.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseDetailsSubscribersGridviewItemAvatar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseDetailsSubscribersGridviewItemPhoneNumber.dart';

class CourseDetailsSubscribersGridviewItem extends StatelessWidget {
  const CourseDetailsSubscribersGridviewItem({
    super.key,
    required this.subscriber,
    this.compact = false,
  });
  final SubscriberEntity subscriber;
  final bool compact;
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
        border: Border.all(
          color: borderColor.withValues(alpha: 0.5),
          width: .5,
        ),
      ),
      child: compact
          ? _buildCompact(context, primaryTextColor)
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 90,
                  width: 90,
                  child: CourseDetailsSubscribersGridviewItemAvatar(
                    imageUrl: subscriber.imageUrl,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        subscriber.name,
                        style: AppTextStyles(
                          context,
                        ).semiBold16.copyWith(color: primaryTextColor),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      CourseDetailsSubscribersGridviewItemPhoneNumber(
                        phone: subscriber.phone,
                      ),
                      const SizedBox(height: 8),
                      CourseDetailsSubscribersGridviewItemAddress(
                        address: subscriber.address,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildCompact(BuildContext context, Color textColor) {
    return Row(
      textDirection: Directionality.of(context),
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: CourseDetailsSubscribersGridviewItemAvatar(
            imageUrl: subscriber.imageUrl,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                subscriber.name.trim().isEmpty ? '—' : subscriber.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles(
                  context,
                ).semiBold16.copyWith(color: textColor),
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      subscriber.phone.trim().isEmpty ? '—' : subscriber.phone,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles(context).regular13.copyWith(
                        color: textColor.withValues(alpha: .75),
                      ),
                    ),
                  ),
                  if (subscriber.educationLevel.trim().isNotEmpty) ...[
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        subscriber.educationLevel,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles(context).regular12.copyWith(
                          color: textColor.withValues(alpha: .65),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 3),
              CourseDetailsSubscribersGridviewItemAddress(
                address: subscriber.address,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 48,
          height: 48,
          child: CustomPhoneIwidget(phoneNumber: subscriber.phone),
        ),
      ],
    );
  }
}

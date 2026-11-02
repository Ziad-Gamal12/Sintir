import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberCallButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/CustomSubscriberDetailsCardAvatar.dart';
import 'package:sintir/locale_keys.dart';

class SubscriberProfileHeader extends StatelessWidget {
  const SubscriberProfileHeader({super.key, required this.subscriberEntity});
  final SubscriberEntity subscriberEntity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final styles = AppTextStyles(context);
    return Row(children: [
      SizedBox(
          width: 64,
          height: 64,
          child: CustomSubscriberDetailsCardAvatar(
            imageUrl: subscriberEntity.imageUrl,
            name: subscriberEntity.name,
          )),
      const SizedBox(width: 12),
      Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subscriberEntity.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: styles.semiBold20
                  .copyWith(color: theme.colorScheme.onSurface)),
          const SizedBox(height: 2),
          Text(
              subscriberEntity.educationLevel.trim().isEmpty
                  ? LocaleKeys.subscriberEducationFallback
                  : subscriberEntity.educationLevel.trim(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: styles.regular14
                  .copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ],
      )),
      const SizedBox(width: 12),
      SubscriberCallButton(phoneNumber: subscriberEntity.phone),
    ]);
  }
}

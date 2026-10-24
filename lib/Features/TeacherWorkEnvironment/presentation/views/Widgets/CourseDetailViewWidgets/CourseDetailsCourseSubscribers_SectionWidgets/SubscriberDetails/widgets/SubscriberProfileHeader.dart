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
    final ThemeData theme = Theme.of(context);
    final Color primaryTextColor = theme.textTheme.bodyLarge!.color!;
    final Color secondaryTextColor = theme.textTheme.bodyMedium!.color!;
    final textStyles = AppTextStyles(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 64,
          height: 64,
          child: CustomSubscriberDetailsCardAvatar(
            imageUrl: subscriberEntity.imageUrl,
          ),
        ),
        SizedBox(
          width: 12,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subscriberEntity.name,
                overflow: TextOverflow.ellipsis,
                style: textStyles.semiBold20.copyWith(color: primaryTextColor),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                subscriberEntity.educationLevel.trim().isEmpty
                    ? LocaleKeys.subscriberEducationFallback
                    : subscriberEntity.educationLevel.trim(),
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles(context)
                    .regular16
                    .copyWith(color: secondaryTextColor),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 12,
        ),
        SubscriberCallButton(phoneNumber: subscriberEntity.phone)
      ],
    );
  }
}

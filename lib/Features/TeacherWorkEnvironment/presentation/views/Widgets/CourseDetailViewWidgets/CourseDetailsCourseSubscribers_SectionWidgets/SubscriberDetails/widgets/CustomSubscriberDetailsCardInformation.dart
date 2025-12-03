import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomSubscriberDetailsCardInformation extends StatelessWidget {
  const CustomSubscriberDetailsCardInformation({
    super.key,
    required this.subscriberentity,
  });

  final SubscriberEntity subscriberentity;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color primaryTextColor = theme.textTheme.bodyLarge!.color!;
    final Color secondaryTextColor = theme.textTheme.bodyMedium!.color!;
    final Color tertiaryTextColor = theme.textTheme.bodySmall!.color!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name
        Text(
          subscriberentity.name,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles(context)
              .semiBold20
              .copyWith(color: primaryTextColor),
        ),
        const SizedBox(
          height: 5,
        ),
        // Phone
        Text(
          subscriberentity.phone,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles(context)
              .regular16
              .copyWith(color: secondaryTextColor),
        ),
        const SizedBox(
          height: 5,
        ),
        // Education Level
        Text(
          subscriberentity.educationLevel == ""
              ? "_"
              : subscriberentity.educationLevel,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles(context)
              .regular16
              .copyWith(color: secondaryTextColor),
        ),
        const SizedBox(
          height: 5,
        ),
        // Address
        Text(
          subscriberentity.address,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles(context)
              .regular16
              .copyWith(color: secondaryTextColor),
        ),
        const SizedBox(
          height: 5,
        ),
        // ID
        Text(
          subscriberentity.id,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles(context)
              .regular14
              .copyWith(color: tertiaryTextColor),
        ),
      ],
    );
  }
}

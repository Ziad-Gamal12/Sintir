import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursefedbackItemEntity.dart';

class CourseDetailsSubscriberReviewsListViewItem extends StatelessWidget {
  const CourseDetailsSubscriberReviewsListViewItem(
      {super.key, required this.reviews});
  final CoursefeedbackItemEntity reviews;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;

    // Background color: Use a subtle color that adapts to the theme
    final Color backgroundColor =
        isDarkMode ? Colors.grey.shade800 : const Color(0xffF2F2F7);

    // Text colors
    final Color titleColor = theme.textTheme.bodyLarge!.color!;
    final Color subtitleColor = theme.textTheme.bodyMedium!.color!;
    final Color trailingColor =
        theme.textTheme.bodySmall!.color!.withOpacity(0.7);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(8)),
      child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: SizedBox(
            width: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(80),
              child: CachedNetworkImage(
                imageUrl: reviews.userImage,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            reviews.name,
            style: AppTextStyles(context).bold16.copyWith(color: titleColor),
          ),
          subtitle: Text(
            reviews.fedBack,
            style: AppTextStyles(context)
                .semiBold16
                .copyWith(color: subtitleColor),
          ),
          trailing: Text(
            "${reviews.datePosted.day}/${reviews.datePosted.month}/${reviews.datePosted.year}",
            style:
                AppTextStyles(context).regular13.copyWith(color: trailingColor),
          )),
    );
  }
}

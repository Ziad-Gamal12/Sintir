import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseCardMetrics.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseItemDetailsContentCreatorCard.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseItemImage.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseItemMeta.dart';
import 'package:sintir/locale_keys.dart';

class CheckoutCourseSummaryCard extends StatelessWidget {
  const CheckoutCourseSummaryCard({super.key, required this.course});

  final CourseEntity course;

  @override
  Widget build(BuildContext context) {
    final creator = course.contentcreaterentity;
    final subject = course.subject.trim();

    return Container(
      key: const ValueKey('checkout-course-summary'),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: CourseCardMetrics.surfaceColor(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CourseCardMetrics.borderColor(context)),
        boxShadow: CourseCardMetrics.shadow(context),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: AspectRatio(
                aspectRatio: CourseCardMetrics.imageAspectRatio,
                child: CourseItemImage(imageUrl: course.posterUrl ?? ''),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (subject.isNotEmpty)
                  Text(
                    LocaleKeys.courseSubjectName(subject),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: CourseCardMetrics.captionStrongStyle(context)
                        .copyWith(color: CourseCardMetrics.accentColor(context)),
                  ),
                Text(
                  course.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: CourseCardMetrics.titleStyle(context).copyWith(
                    color: CourseCardMetrics.textColor(context),
                  ),
                ),
                if (creator != null && creator.name.trim().isNotEmpty) ...[
                  const SizedBox(height: 4),
                  CourseItemDetailsContentCreatorCard(
                    contentcreaterentity: creator,
                  ),
                ],
                const SizedBox(height: 4),
                CourseItemMeta(course: course),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseCardMetrics.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseItemDetailsContentCreatorCard.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseItemPrice.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseItemStudentsCount.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseItemTitleBlock.dart';
import 'package:sintir/Features/ContentCreatorProfile/Presentation/Views/ContentCreatorProfile.dart';

class CourseItemDetails extends StatelessWidget {
  const CourseItemDetails({super.key, required this.courseItem});

  final CourseEntity courseItem;

  @override
  Widget build(BuildContext context) {
    final creator = courseItem.contentcreaterentity;

    return LayoutBuilder(
      builder: (context, constraints) {
        final titleBlockHeight = CourseCardMetrics.titleBlockHeight(context);
        final metaHeight = CourseCardMetrics.metaHeight(context);
        final showCreator =
            creator != null &&
            constraints.maxHeight >=
                titleBlockHeight +
                    CourseCardMetrics.titleToMetaGap +
                    metaHeight +
                    4 +
                    CourseCardMetrics.creatorHeight -
                    1;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: titleBlockHeight,
              width: double.infinity,
              child: CourseItemTitleBlock(
                title: courseItem.title,
                description: courseItem.description,
              ),
            ),
            const SizedBox(height: CourseCardMetrics.titleToMetaGap),
            Row(
              children: [
                Flexible(child: CourseItemPrice(price: courseItem.price)),
                const Spacer(),
                if (courseItem.studentsCount > 0)
                  CourseItemStudentsCount(count: courseItem.studentsCount),
              ],
            ),
            const Spacer(),
            if (showCreator)
              CourseItemDetailsContentCreatorCard(
                contentcreaterentity: creator,
                onTap: () => GoRouter.of(
                  context,
                ).push(ContentCreatorProfile.routeName, extra: creator),
              ),
          ],
        );
      },
    );
  }
}

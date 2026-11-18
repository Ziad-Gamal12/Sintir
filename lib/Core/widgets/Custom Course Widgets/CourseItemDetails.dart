import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseCardMetrics.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseItemDetailsContentCreatorCard.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseItemMeta.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseItemPrice.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseItemTitleBlock.dart';
import 'package:sintir/Features/ContentCreatorProfile/Presentation/Views/ContentCreatorProfile.dart';

class CourseItemDetails extends StatelessWidget {
  const CourseItemDetails({super.key, required this.courseItem});

  final CourseEntity courseItem;

  @override
  Widget build(BuildContext context) {
    final creator = courseItem.contentcreaterentity;
    Widget? creatorRow;
    if (creator != null && creator.name.trim().isNotEmpty) {
      creatorRow = CourseItemDetailsContentCreatorCard(
        contentcreaterentity: creator,
        onTap: () => GoRouter.of(
          context,
        ).push(ContentCreatorProfile.routeName, extra: creator),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: CourseCardMetrics.titleBlockHeight(context),
          child: CourseItemTitleBlock(title: courseItem.title),
        ),
        const SizedBox(height: CourseCardMetrics.rowGap),
        SizedBox(
          height: CourseCardMetrics.creatorRowHeight(context),
          child: creatorRow,
        ),
        const SizedBox(height: CourseCardMetrics.rowGap),
        SizedBox(
          height: CourseCardMetrics.metaHeight(context),
          child: CourseItemMeta(course: courseItem),
        ),
        const Spacer(),
        CourseItemPrice(price: courseItem.price),
      ],
    );
  }
}

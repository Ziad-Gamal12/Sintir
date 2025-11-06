import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CourseItemDetails extends StatelessWidget {
  const CourseItemDetails({
    super.key,
    required this.courseItem,
  });

  final CourseEntity courseItem;

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyles(context);

    return Padding(
      padding: const EdgeInsets.only(right: 4, bottom: 10, left: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ✅ Title
          Text(
            courseItem.title,
            maxLines: 1,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: styles.semiBold12.copyWith(color: Colors.black),
          ),

          const SizedBox(height: 6),

          /// ✅ Instructor Name
          if (courseItem.contentcreaterentity?.name != null)
            Text(
              courseItem.contentcreaterentity!.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: styles.regular10.copyWith(color: Colors.red),
            ),

          const SizedBox(height: 4),

          /// ✅ (Students + Level) Row
          Row(
            children: [
              Icon(Icons.person, size: 12, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                "${courseItem.studentsCount} طالب",
                style: styles.regular10.copyWith(color: Colors.grey[700]),
              ),
              const SizedBox(width: 12),
              Text(
                "• ${courseItem.level}",
                style: styles.regular10.copyWith(color: Colors.grey[700]),
              ),
            ],
          ),

          const SizedBox(height: 6),

          /// ✅ Short description
          Text(
            courseItem.description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: styles.regular10.copyWith(color: const Color(0xff818181)),
          ),

          const Spacer(),

          /// ✅ Price
          Text(
            "${courseItem.price} جنيه",
            textAlign: TextAlign.right,
            style: styles.semiBold14.copyWith(color: Colors.red),
          ),
        ],
      ),
    );
  }
}

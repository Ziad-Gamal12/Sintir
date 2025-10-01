import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomContentCreatorCircleAvartar.dart';

class CourseItemDetails extends StatelessWidget {
  const CourseItemDetails({super.key, required this.courseItem});
  final CourseEntity courseItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            courseItem.title,
            textAlign: TextAlign.right,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:
                AppTextStyles(context).semiBold11.copyWith(color: Colors.black),
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              CustomContentCreatorCircleAvartar(
                imagepath:
                    courseItem.contentcreaterentity?.profileImageUrl ?? "",
              ),
              const SizedBox(width: 10),
              Text(
                courseItem.contentcreaterentity?.name ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles(context)
                    .regular10
                    .copyWith(color: const Color(0xff818181)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

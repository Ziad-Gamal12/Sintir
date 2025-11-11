import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/ContentCreaterEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomContentCreatorCircleAvartar.dart';

class CourseItemDetailsContentCreatorCard extends StatelessWidget {
  const CourseItemDetailsContentCreatorCard({
    super.key,
    required this.contentcreaterentity,
  });

  final Contentcreaterentity contentcreaterentity;

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyles(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade100, width: .5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 7,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          CustomContentCreatorCircleAvartar(
            imagepath: contentcreaterentity.profileImageUrl,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            contentcreaterentity.name,
            maxLines: 2,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: styles.semiBold12.copyWith(color: Colors.black),
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey.shade400,
            size: 15,
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/ContentCreaterEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';

class SearchViewBodyTeachersListViewItem extends StatelessWidget {
  const SearchViewBodyTeachersListViewItem(
      {super.key, required this.contentcreaterentity});
  final Contentcreaterentity contentcreaterentity;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(45),
              child: CustomCachedNetworkImage(
                  imageUrl: contentcreaterentity.profileImageUrl),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Expanded(
          child: Text(
            contentcreaterentity.name,
            style: AppTextStyles(context).regular14,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/ContentCreaterEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';

class ContentCreatorDetails extends StatelessWidget {
  const ContentCreatorDetails({
    super.key,
    required this.contentcreaterentity,
  });

  final Contentcreaterentity contentcreaterentity;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.transparent,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CustomCachedNetworkImage(
                      imageUrl: contentcreaterentity.profileImageUrl,
                    )),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    contentcreaterentity.name,
                    style: AppTextStyles(context).semiBold20,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    contentcreaterentity.title,
                    style: AppTextStyles(context).regular16,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    contentcreaterentity.id,
                    style: AppTextStyles(context).regular16,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

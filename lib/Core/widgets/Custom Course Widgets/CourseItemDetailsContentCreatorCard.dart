import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/ContentCreaterEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomContentCreatorCircleAvartar.dart';

class CourseItemDetailsContentCreatorCard extends StatelessWidget {
  const CourseItemDetailsContentCreatorCard({
    super.key,
    required this.contentcreaterentity,
    this.onTap,
  });

  final Contentcreaterentity contentcreaterentity;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(
          height: 1,
          thickness: .5,
          color: isDark ? Colors.white12 : Colors.black12,
        ),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                CustomContentCreatorCircleAvartar(
                  imagepath: contentcreaterentity.profileImageUrl,
                  radius: 11,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    contentcreaterentity.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles(context).regular12.copyWith(
                      color: isDark ? Colors.white70 : Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

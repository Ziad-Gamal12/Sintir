import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/ContentCreaterEntity.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseCardMetrics.dart';
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
    final row = Row(
      children: [
        _CreatorAvatar(
          name: contentcreaterentity.name,
          imageUrl: contentcreaterentity.profileImageUrl,
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            contentcreaterentity.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: CourseCardMetrics.captionStyle(context).copyWith(
              color: CourseCardMetrics.mutedColor(context),
            ),
          ),
        ),
      ],
    );
    if (onTap == null) return row;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: row,
    );
  }
}

class _CreatorAvatar extends StatelessWidget {
  const _CreatorAvatar({required this.name, required this.imageUrl});

  final String name;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    const size = CourseCardMetrics.avatarSize;
    if (imageUrl.trim().isNotEmpty) {
      return SizedBox.square(
        dimension: size,
        child: CustomContentCreatorCircleAvartar(
          imagepath: imageUrl,
          radius: size / 2,
        ),
      );
    }
    final trimmed = name.trim();
    final initial = trimmed.isEmpty
        ? '?'
        : String.fromCharCode(trimmed.runes.first).toUpperCase();
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: CourseCardMetrics.iconBackground(context),
        shape: BoxShape.circle,
      ),
      child: Text(
        initial,
        style: CourseCardMetrics.captionStrongStyle(context).copyWith(
          fontSize: 10,
          height: 1,
          color: CourseCardMetrics.accentColor(context),
        ),
      ),
    );
  }
}

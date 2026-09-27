import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';

class CourseInstructorAvatar extends StatelessWidget {
  const CourseInstructorAvatar({super.key, required this.course});

  final CourseEntity course;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imageUrl = course.contentcreaterentity?.profileImageUrl.trim();

    if (imageUrl == null || imageUrl.isEmpty) {
      return CircleAvatar(
        radius: 24,
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        child: const Icon(Icons.school_outlined),
      );
    }

    return CircleAvatar(
      radius: 24,
      backgroundColor: theme.colorScheme.primary.withValues(alpha: .12),
      child: ClipOval(
        child: SizedBox(
          width: 48,
          height: 48,
          child: CustomCachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

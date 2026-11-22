import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';

/// A section that was saved to a course.
///
/// Published by [CourseSectionsRepo.addedSections] after a successful write so
/// screens lower in the navigation stack can show it without refetching.
final class AddedCourseSection {
  const AddedCourseSection({required this.courseId, required this.section});

  final String courseId;
  final CourseSectionEntity section;
}

/// A video, file or test that was saved to a course section.
///
/// Published by [SectionItemsActionsRepo.addedItems] after a successful write.
final class AddedSectionItem {
  const AddedSectionItem({
    required this.courseId,
    required this.sectionId,
    required this.item,
  });

  final String courseId;
  final String sectionId;
  final dynamic item;
}

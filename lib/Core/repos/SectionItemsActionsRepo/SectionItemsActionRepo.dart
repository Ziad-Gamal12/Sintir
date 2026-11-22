import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/course_content_changes.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/JoinedByEntity.dart';

abstract class SectionItemsActionsRepo {
  /// Every item [addSectionItem] saves successfully, from any screen.
  Stream<AddedSectionItem> get addedItems;

  Future<Either<Failure, void>> addSectionItem({
    required dynamic sectionItem,
    required String teacherId,
    required String courseId,
    required String sectionId,
  });
  Future<Either<Failure, List>> getSectionsItems({
    required String courseId,
    required String sectionId,
  });
  Future<Either<Failure, void>> deleteSectionItem({
    required String courseId,
    required String teacherId,
    required String sectionId,
    required String sectionItemId,
    required bool isTest,
  });
  Future<Either<Failure, void>> addJoinedBy({
    required JoinedByEntity joinedByEntity,
    required String courseId,
    required String sectionId,
    required String sectionItemId,
  });
}

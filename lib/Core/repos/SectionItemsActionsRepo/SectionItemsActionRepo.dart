import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/JoinedByEntity.dart';

abstract class SectionItemsActionsRepo {
  Future<Either<Failure, void>> addSectionItem({
    required sectionItem,
    required String courseId,
    required String sectionId,
  });
  // SectionItemsActionsRepo
  Future<Either<Failure, List>> getSectionsItems(
      {required String courseId, required String sectionId});
  // SectionItemsActionsRepo
  Future<Either<Failure, void>> addJoinedBy(
      {required JoinedByEntity joinedByEntity,
      required String courseId,
      required String sectionId,
      required String sectionItemId});
}

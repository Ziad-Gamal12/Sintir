// ignore_for_file: file_names, depend_on_referenced_packages

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetCourseSectionsResonseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/CourseSectionsRepos/CourseSectionsRepo.dart';
import 'package:sintir/Core/repos/SectionItemsActionsRepo/SectionItemsActionRepo.dart';

part 'CourseSectionsState.dart';

class CourseSectionsCubit extends Cubit<CourseSectionsState> {
  CourseSectionsCubit({
    required this.courseSectionsRepo,
    required this.sectionItemsActionsRepo,
  }) : super(AddCourseSectionInitial());

  final CourseSectionsRepo courseSectionsRepo;
  final SectionItemsActionsRepo sectionItemsActionsRepo;

  void _emitFailure(Failure failure) {
    emit(AddCourseSectionFailure(errMessage: failure.message));
  }

  Future<void> addCourseSection({
    required CourseSectionEntity section,
    required String courseId,
    required dynamic sectionItem,
    required String teacherId,
  }) async {
    emit(AddCourseSectionLoading());

    final Either<Failure, void> addSectionResult = await courseSectionsRepo
        .addCourseSection(section: section, courseId: courseId);

    addSectionResult.fold(
      (failure) {
        _emitFailure(failure);
      },
      (r) async {
        final Either<Failure, void> addItemResult =
            await sectionItemsActionsRepo.addSectionItem(
              courseId: courseId,
              sectionId: section.id,
              sectionItem: sectionItem,
              teacherId: teacherId,
            );

        addItemResult.fold(
          (failure) => _emitFailure(failure),
          (_) => emit(AddCourseSectionSuccess()),
        );
      },
    );
  }

  Future<void> addSectionItem({
    required String courseId,
    required String sectionId,
    required dynamic sectionItem,
    required String teacherId,
  }) async {
    emit(AddCourseSectionItemLoading());

    final Either<Failure, void> result = await sectionItemsActionsRepo
        .addSectionItem(
          sectionItem: sectionItem,
          courseId: courseId,
          sectionId: sectionId,
          teacherId: teacherId,
        );

    result.fold(
      (failure) =>
          emit(AddCourseSectionItemFailure(errMessage: failure.message)),
      (_) => emit(AddCourseSectionItemSuccess()),
    );
  }

  Future<void> getCourseSections({
    required String courseId,
    required bool isPaginate,
  }) async {
    emit(GetCourseSectionsLoading());

    final Either<Failure, GetCourseSectionsResonseEntity> result =
        await courseSectionsRepo.getCourseSections(
          courseId: courseId,
          isPaginate: isPaginate,
        );

    result.fold(
      (failure) => emit(GetCourseSectionsFailure(errMessage: failure.message)),
      (sections) => emit(GetCourseSectionsSuccess(response: sections)),
    );
  }

  Future<void> getSectionItems({
    required String sectionId,
    required String courseId,
  }) async {
    emit(GetSectionItemsLoading(sectionId: sectionId));

    final Either<Failure, List<dynamic>> result = await sectionItemsActionsRepo
        .getSectionsItems(courseId: courseId, sectionId: sectionId);

    result.fold(
      (failure) => emit(GetSectionItemsFailure(errMessage: failure.message)),
      (items) =>
          emit(GetSectionItemsSuccess(items: items, sectionId: sectionId)),
    );
  }

  Future<void> deleteSectionItem({
    required String courseId,
    required String sectionId,
    required String sectionItemId,
    required String teacherId,
    required bool isTest,
  }) async {
    emit(DeleteSectionItemLoading(sectionItemId: sectionItemId));

    final Either<Failure, void> result = await sectionItemsActionsRepo
        .deleteSectionItem(
          courseId: courseId,
          sectionId: sectionId,
          teacherId: teacherId,
          sectionItemId: sectionItemId,
          isTest: isTest,
        );

    result.fold(
      (failure) => emit(DeleteSectionItemFailure(errMessage: failure.message)),
      (_) => emit(DeleteSectionItemSuccess(deletedItemId: sectionItemId)),
    );
  }

  Future<void> deleteSection({
    required String courseId,
    required String sectionId,
    required String teacherId,
  }) async {
    emit(DeleteSectionLoading(sectionId: sectionId));

    final Either<Failure, void> result = await courseSectionsRepo.deleteSection(
      courseId: courseId,
      sectionId: sectionId,
      teacherId: teacherId,
    );

    result.fold(
      (failure) => emit(DeleteSectionFailure(errMessage: failure.message)),
      (_) => emit(DeleteSectionSuccess(deletedSectionId: sectionId)),
    );
  }
}

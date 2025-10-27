// ignore_for_file: file_names, depend_on_referenced_packages

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/entities/GetCourseSectionsResonseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/repos/CourseSectionsRepos/CourseSectionsRepo.dart';

part 'CourseSectionsState.dart';

class CourseSectionsCubit extends Cubit<CourseSectionsState> {
  CourseSectionsCubit(
    this.coursesectionrepo,
    this.assetspickerrepo,
  ) : super(AddCourseSectionInitial());
  final CourseSectionsRepo coursesectionrepo;
  final Assetspickerrepo assetspickerrepo;

  void addCourseSection({
    required CourseSectionEntity section,
    required String courseId,
    required sectionItem,
  }) async {
    Either<Failure, void> result = await coursesectionrepo.addCourseSection(
        section: section, courseId: courseId);
    result.fold((failure) {
      emit(AddCourseSectionFailure(errMessage: failure.message));
    }, (success) async {
      final result = await coursesectionrepo.addSectionItem(
          courseId: courseId, sectionId: section.id, sectionItem: sectionItem);
      result.fold((failure) {
        emit(AddCourseSectionFailure(errMessage: failure.message));
      }, (success) {
        emit(AddCourseSectionSuccess());
      });
    });
  }

  void addSectionItem({
    required String courseId,
    required String sectionId,
    required dynamic sectionItem,
  }) async {
    emit(AddCourseSectionItemLoading());
    final result = await coursesectionrepo.addSectionItem(
        sectionItem: sectionItem, courseId: courseId, sectionId: sectionId);
    result.fold((failure) {
      emit(AddCourseSectionItemFailure(errMessage: failure.message));
    }, (sucUpdateCourseSectionsFailurecess) {
      emit(AddCourseSectionItemSuccess());
    });
  }

  Future<void> getCourseSections(
      {required String courseId, required bool isPaginate}) async {
    emit(GetCourseSectionsLoading());
    Either<Failure, GetCourseSectionsResonseEntity> result =
        await coursesectionrepo.getCourseSections(
            courseId: courseId, isPaginate: isPaginate);
    result.fold((failure) {
      emit(GetCourseSectionsFailure(errMessage: failure.message));
    }, (sections) {
      emit(GetCourseSectionsSuccess(response: sections));
    });
  }

  void getSectionItems(
      {required String sectionId, required String courseId}) async {
    emit(GetSectionItemsLoading(
      sectionId: sectionId,
    ));
    Either<Failure, List> result = await coursesectionrepo.getSectionsItems(
        courseId: courseId, sectionId: sectionId);
    result.fold((failure) {
      emit(GetSectionItemsFailure(errMessage: failure.message));
    }, (items) {
      emit(GetSectionItemsSuccess(items: items, sectionId: sectionId));
    });
  }

  Future<void> deleteSectionItem({
    required String courseId,
    required String sectionId,
    required String sectionItemId,
  }) async {
    emit(DeleteSectionItemLoading());
    final result = await coursesectionrepo.deleteSectionItem(
        courseId: courseId, sectionId: sectionId, sectionItemId: sectionItemId);
    result.fold((failure) {
      emit(DeleteSectionItemFailure(errMessage: failure.message));
    }, (success) {
      emit(DeleteSectionItemSuccess());
    });
  }

  Future<void> deleteSection({
    required String courseId,
    required String sectionId,
  }) async {
    emit(DeleteSectionLoading());
    final result = await coursesectionrepo.deleteSection(
        courseId: courseId, sectionId: sectionId);
    result.fold((failure) {
      emit(DeleteSectionFailure(errMessage: failure.message));
    }, (success) {
      emit(DeleteSectionSuccess());
    });
  }
}

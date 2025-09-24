// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/repos/File-Item-Repo/FileItemRepo.dart';
import 'package:sintir/Core/repos/SectionItemsActionsRepo/SectionItemsActionRepo.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/JoinedByEntity.dart';

part 'file_item_state.dart';

class FileItemCubit extends Cubit<FileItemState> {
  FileItemCubit(
      {required this.fileItemRepo,
      required this.sectionItemsActionsRepo,
      required this.assetspickerrepo})
      : super(FileItemInitial());
  final FileItemRepo fileItemRepo;
  final SectionItemsActionsRepo sectionItemsActionsRepo;
  final Assetspickerrepo assetspickerrepo;
  void joinToFileItem({
    required JoinedByEntity joinedByEntity,
    required String courseId,
    required String sectionId,
    required String sectionItemId,
  }) async {
    emit(JoinToFileITemLoading());
    Either<Failure, void> result = await sectionItemsActionsRepo.addJoinedBy(
        joinedByEntity: joinedByEntity,
        courseId: courseId,
        sectionId: sectionId,
        sectionItemId: sectionItemId);
    result.fold((failure) {
      emit(JoinToFileITemFailure(errMessage: failure.message));
    }, (sucUpdateCourseSectionsFailurecess) {
      emit(JoinToFileITemSuccess());
    });
  }

  void pickSectionFile() async {
    final result = await assetspickerrepo.pickFile();
    result.fold((failure) {
      emit(PickFileFailure());
    }, (file) {
      emit(PickFileSuccess(file: file));
    });
  }

  void uploadFile({
    required CourseFileEntity coursefileEntity,
  }) async {
    emit(UplaodFileLoading());
    var result =
        await fileItemRepo.uploadFile(coursefileEntity: coursefileEntity);
    result.fold((failure) {
      emit(UplaodFileFailure(errMessage: failure.message));
    }, (url) {
      emit(UplaodFileSuccess(url: url));
    });
  }

  void addFileItem({
    required String courseId,
    required String sectionId,
    required CourseFileEntity file,
  }) async {
    emit(AddFileItemLoading());
    final result = await sectionItemsActionsRepo.addSectionItem(
        sectionItem: file, courseId: courseId, sectionId: sectionId);
    result.fold((failure) {
      emit(AddFileItemFailure(errMessage: failure.message));
    }, (sucUpdateCourseSectionsFailurecess) {
      emit(AddFileItemSuccess());
    });
  }
}

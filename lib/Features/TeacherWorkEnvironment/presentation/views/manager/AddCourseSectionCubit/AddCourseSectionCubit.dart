import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionSolutionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseVedioItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/repos/AddCourseSectionRepo.dart';

part 'AddCourseSectionState.dart';

class AddCourseSectionCubit extends Cubit<AddCourseSectionState> {
  AddCourseSectionCubit(
    this.addcoursesectionrepo,
    this.assetspickerrepo,
  ) : super(AddCourseSectionInitial());
  final Addcoursesectionrepo addcoursesectionrepo;
  final Assetspickerrepo assetspickerrepo;

  void addNewQuestion({required Coursetestentity coursetestentity}) {
    coursetestentity.addQuestion(null);
    emit(AddCourseSectionTestQuestionAdded());
  }

  void removeQuestion(
      {required Coursetestentity coursetestentity,
      required Coursetestquestionentity question}) {
    coursetestentity.removeQuestion(question);
    emit(AddCourseSectionTestQuestionRemoved());
  }

  void removeSolutin(
      {required Coursetestquestionsolutionentity solution,
      required Coursetestentity coursetestentity,
      required Coursetestquestionentity question}) {
    if (question.solutions.length > 1) {
      question.removeSolution(solution);
    } else {
      removeQuestion(question: question, coursetestentity: coursetestentity);
    }
    emit(AddCourseSectionTestSolutionRemoved());
  }

  void addSolution({required Coursetestquestionentity question}) {
    question.addSolution(null);
    emit(AddCourseSectionTestSolutionAdded());
  }

  void changeSelectedSolution(
      {required Coursetestquestionentity question, required int index}) {
    for (var solution in question.solutions) {
      solution.isCorrect = false;
    }
    question.solutions[index].isCorrect = true;

    emit(AddCourseSectionTestSolutionChanged());
  }

  void updateCourseSections({
    required CourseEntity courseEntity,
  }) async {
    Either<Failure, void> result =
        await addcoursesectionrepo.updateCourseSections(
      courseEntity: courseEntity,
    );
    result.fold((failure) {
      emit(UpdateCourseSectionsFailure(errMessage: failure.message));
    }, (success) {
      emit(UpdateCourseSectionsSuccess());
    });
  }

  void pickSectionVedio(
      {required Coursevedioitementity coursevedioitementity}) async {
    final result = await assetspickerrepo.pickVideoFromGallery();
    result.fold((failure) {
      emit(AddCourseSectionVedioUnPicked());
    }, (vedio) {
      coursevedioitementity.file = vedio;
      emit(AddCourseSectionVedioPicked(videoFile: vedio));
    });
  }

  void pickSectionFile() async {
    final result = await assetspickerrepo.pickFile();
    result.fold((failure) {
      emit(AddCourseSectionFileUnPicked());
    }, (file) {
      emit(AddCourseSectionFilePicked(file: file));
    });
  }

  void uploadFile({
    required Coursefileentity coursefileEntity,
  }) async {
    emit(FileUploadedingLoading());
    var result = await addcoursesectionrepo.uploadFile(
        coursefileEntity: coursefileEntity);
    result.fold((failure) {
      emit(FileUploadedingFailure(errMessage: failure.message));
    }, (url) {
      emit(FileUploadedingSuccuss(url: url));
    });
  }

  void uploadVideo({
    required Coursevedioitementity coursevedioitementity,
  }) async {
    emit(VideoUploadedingLoading());
    var result = await addcoursesectionrepo.uploadVideo(
        coursevedioitementity: coursevedioitementity);
    result.fold((failure) {
      emit(VideoUploadedingFailure(errMessage: failure.message));
    }, (url) {
      emit(VideoUploadedingSuccuss(url: url));
    });
  }

  void uploadTestQuestionsImages({
    required Coursetestentity test,
  }) async {
    emit(QuestionsImagesUploadedingLoading());
    var resulte = await addcoursesectionrepo.uploadTestQuestionsImages(
        questions: test.questions);
    resulte.fold((failure) {
      emit(QuestionsImagesUploadedingFailure(errMessage: failure.message));
    }, (success) {
      emit(QuestionsImagesUploadedingSuccuss());
    });
  }
}

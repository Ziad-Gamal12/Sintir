// ignore_for_file: file_names, depend_on_referenced_packages

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/user_cubit/user_cubit.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/repos/CourseSectionsRepos/CourseSectionsRepo.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursSectionsListItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionSolutionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseVedioItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/JoinedByEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/TestResulteEntity.dart';

part 'CourseSectionsState.dart';

class CourseSectionsCubit extends Cubit<CourseSectionsState> {
  CourseSectionsCubit(
    this.coursesectionrepo,
    this.assetspickerrepo,
  ) : super(AddCourseSectionInitial());
  final CourseSectionsRepo coursesectionrepo;
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

  void addCourseSection({
    required CourseSectionEntity section,
    required String courseId,
    required sectionItem,
  }) async {
    Either<Failure, void> result = await coursesectionrepo.addCourseSection(
        section: section, courseId: courseId, sectionItem: sectionItem);
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
    var result =
        await coursesectionrepo.uploadFile(coursefileEntity: coursefileEntity);
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
    var result = await coursesectionrepo.uploadVideo(
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
    var resulte = await coursesectionrepo.uploadTestQuestionsImages(
        questions: test.questions);
    resulte.fold((failure) {
      emit(QuestionsImagesUploadedingFailure(errMessage: failure.message));
    }, (success) {
      emit(QuestionsImagesUploadedingSuccuss());
    });
  }

  void getCourseSections({required String courseId}) async {
    emit(GetCourseSectionsLoading());
    Either<Failure, List<CourseSectionEntity>> result =
        await coursesectionrepo.getCourseSections(courseId: courseId);
    result.fold((failure) {
      emit(GetCourseSectionsFailure(errMessage: failure.message));
    }, (sections) {
      emit(GetCourseSectionsSuccess(sections: sections));
    });
  }

  void getSectionItems(
      {required String sectionId, required String courseId}) async {
    emit(GetSectionItemsLoading());
    Either<Failure, List> result = await coursesectionrepo.getSectionsItems(
        courseId: courseId, sectionId: sectionId);
    result.fold((failure) {
      emit(GetSectionItemsFailure(errMessage: failure.message));
    }, (items) {
      emit(GetSectionItemsSuccess(items: items));
    });
  }

  void addJoinedBy({
    required JoinedByEntity joinedByEntity,
    required String courseId,
    required String sectionId,
    required String sectionItemId,
  }) async {
    emit(AddJoinedByLoading());
    Either<Failure, void> result = await coursesectionrepo.addJoinedBy(
        joinedByEntity: joinedByEntity,
        courseId: courseId,
        sectionId: sectionId,
        sectionItemId: sectionItemId);
    result.fold((failure) {
      emit(AddJoinedByFailure(errMessage: failure.message));
    }, (sucUpdateCourseSectionsFailurecess) {
      emit(AddJoinedBySuccess());
    });
  }

  JoinedByEntity getJoinedByEntity({required BuildContext context}) {
    if (context.read<UserCubit>().teacherentity != null) {
      return JoinedByEntity(
        imageUrl: context.read<UserCubit>().teacherentity!.profilePicurl!,
        name: context.read<UserCubit>().teacherentity!.firstName,
        joinedDate: DateTime.now(),
        uid: context.read<UserCubit>().teacherentity!.uid!,
      );
    } else if (context.read<UserCubit>().studententity != null) {
      return JoinedByEntity(
        imageUrl: context.read<UserCubit>().studententity!.imageUrl,
        name: context.read<UserCubit>().studententity!.firstName,
        joinedDate: DateTime.now(),
        uid: context.read<UserCubit>().studententity!.uid!,
      );
    } else {
      return JoinedByEntity(
        imageUrl: "",
        name: "غير معروف",
        joinedDate: DateTime.now(),
        uid: "",
      );
    }
  }

  int getResult({required Coursetestentity test}) {
    int result = 0;
    for (var element in test.questions) {
      String selectedAnswer = element.selectedSolution ?? "null";
      for (var solution in element.solutions) {
        String correctAnswer = solution.isCorrect ? solution.answer : "null";
        if (selectedAnswer == correctAnswer) {
          result++;
        }
      }
    }
    return result;
  }

  List<ExamResultSolvedQuestionEntity> getSolvedQuestionsnums(
      {required Coursetestentity test}) {
    List<ExamResultSolvedQuestionEntity> numbers = [];
    for (var element in test.questions) {
      if (element.selectedSolution != null) {
        numbers.add(ExamResultSolvedQuestionEntity(
          imageUrl: element.imageUrl ?? "",
          questionTitle: element.questionTitle ?? "null",
          isCorrect: element.selectedSolution ==
              element.solutions
                  .where((element) => element.isCorrect)
                  .first
                  .answer,
          rightAnswer: element.solutions
              .where((element) => element.isCorrect)
              .first
              .answer,
          selectedAnswer: element.selectedSolution ?? "null",
        ));
      }
    }

    return numbers;
  }

  TestresulteEntity getTestResults(
      {required BuildContext context, required Coursetestentity test}) {
    return TestresulteEntity(
        joinedDate: DateTime.now(),
        serialNumber: "${DateTime.now().toString()}-Result",
        joinedbyentity: getJoinedByEntity(context: context),
        result: getResult(test: test),
        solvedQuestions: getSolvedQuestionsnums(test: test).length,
        totalQuestions: test.questions.length,
        questionsSolvedListEntity: getSolvedQuestionsnums(test: test));
  }

  void addTestResults(
      {required Coursetestentity test,
      required String courseId,
      required String sectionId,
      required String sectionItemId,
      required BuildContext context}) async {
    emit(AddTestResultLoading());
    Either<Failure, void> result = await coursesectionrepo.addTestResult(
        testResult: getTestResults(context: context, test: test),
        courseId: courseId,
        sectionId: sectionId,
        sectionItemId: sectionItemId);
    result.fold((failure) {
      emit(AddTestResultFailure(errMessage: failure.message));
    }, (sucUpdateCourseSectionsFailurecess) {
      emit(AddTestResultSuccess());
    });
  }
}

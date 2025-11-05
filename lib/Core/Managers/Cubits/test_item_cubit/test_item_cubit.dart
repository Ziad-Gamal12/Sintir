// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionSolutionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/repos/SectionItemsActionsRepo/SectionItemsActionRepo.dart';
import 'package:sintir/Core/repos/Test-Item-Repo/TestItemRepo.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/JoinedByEntity.dart';

part 'test_item_state.dart';

class TestItemCubit extends Cubit<TestItemState> {
  TestItemCubit(
      {required this.testitemrepo,
      required this.sectionItemsActionsRepo,
      required this.assetspickerrepo})
      : super(TestItemInitial());
  final Testitemrepo testitemrepo;
  final SectionItemsActionsRepo sectionItemsActionsRepo;
  final Assetspickerrepo assetspickerrepo;

  void addNewQuestion({required CourseTestEntity coursetestentity}) {
    coursetestentity.addQuestion(null);
    emit(AddCourseSectionTestQuestionAdded());
  }

  void removeQuestion(
      {required CourseTestEntity coursetestentity,
      required CourseTestQuestionEntity question}) {
    coursetestentity.removeQuestion(question);
    emit(AddCourseSectionTestQuestionRemoved());
  }

  void removeSolutin(
      {required Coursetestquestionsolutionentity solution,
      required CourseTestEntity coursetestentity,
      required CourseTestQuestionEntity question}) {
    if (question.solutions.length > 1) {
      question.removeSolution(solution);
    } else {
      removeQuestion(question: question, coursetestentity: coursetestentity);
    }
    emit(AddCourseSectionTestSolutionRemoved());
  }

  void addSolution({required CourseTestQuestionEntity question}) {
    question.addSolution(null);
    emit(AddCourseSectionTestSolutionAdded());
  }

  void changeSelectedSolution(
      {required CourseTestQuestionEntity question, required int index}) {
    for (var solution in question.solutions) {
      solution.isCorrect = false;
    }
    question.solutions[index].isCorrect = true;

    emit(AddCourseSectionTestSolutionChanged());
  }

  void uploadTestQuestionsImages({
    required CourseTestEntity test,
  }) async {
    emit(QuestionsImagesUploadedingLoading());
    var resulte =
        await testitemrepo.uploadTestQuestionsImages(questions: test.questions);
    resulte.fold((failure) {
      emit(QuestionsImagesUploadedingFailure(errMessage: failure.message));
    }, (success) {
      emit(QuestionsImagesUploadedingSuccuss());
    });
  }

  void addTestItem({
    required String courseId,
    required String sectionId,
    required CourseTestEntity test,
  }) async {
    emit(AddTestItemLoading());
    final result = await sectionItemsActionsRepo.addSectionItem(
        sectionItem: test, courseId: courseId, sectionId: sectionId);
    result.fold((failure) {
      emit(AddTestItemFailure(errMessage: failure.message));
    }, (sucUpdateCourseSectionsFailurecess) {
      emit(AddTestItemSuccess());
    });
  }

  int getResult({required CourseTestEntity test}) {
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
      {required CourseTestEntity test}) {
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

  TestResultEntity getTestResults(
      {required BuildContext context,
      required CourseTestEntity test,
      required UserEntity user}) {
    return TestResultEntity(
        isPassed: getResult(test: test) >= (test.questions.length / 2),
        joinedDate: DateTime.now(),
        serialNumber: "${DateTime.now().toString()}-Result",
        joinedbyentity: JoinedByEntity(
          uid: user.uid,
          name: user.fullName,
          imageUrl: user.profilePicurl,
          joinedDate: DateTime.now(),
        ),
        result: getResult(test: test),
        solvedQuestions: getSolvedQuestionsnums(test: test).length,
        totalQuestions: test.questions.length,
        questionsSolvedListEntity: getSolvedQuestionsnums(test: test));
  }

  void addTestResults(
      {required CourseTestEntity test,
      required String courseId,
      required String sectionId,
      required String sectionItemId,
      required String userId,
      required BuildContext context}) async {
    emit(AddTestResultLoading());
    Either<Failure, void> result = await testitemrepo.addTestResult(
        userUID: userId,
        testResult:
            getTestResults(context: context, test: test, user: getUserData()),
        courseId: courseId,
        sectionId: sectionId,
        sectionItemId: sectionItemId);
    result.fold((failure) {
      emit(AddTestResultFailure(errMessage: failure.message));
    }, (sucUpdateCourseSectionsFailurecess) {
      emit(AddTestResultSuccess());
    });
  }

  void joinToTestItem({
    required JoinedByEntity joinedByEntity,
    required String courseId,
    required String sectionId,
    required String sectionItemId,
  }) async {
    emit(JoinToTestItemLoading());
    Either<Failure, void> result = await sectionItemsActionsRepo.addJoinedBy(
        joinedByEntity: joinedByEntity,
        courseId: courseId,
        sectionId: sectionId,
        sectionItemId: sectionItemId);
    result.fold((failure) {
      emit(JoinToTestItemFailure(errMessage: failure.message));
    }, (sucUpdateCourseSectionsFailurecess) {
      emit(JoinToTestItemSuccess());
    });
  }
}

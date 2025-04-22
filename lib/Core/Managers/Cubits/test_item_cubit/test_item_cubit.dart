// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/user_cubit/user_cubit.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/repos/SectionItemsActionsRepo/SectionItemsActionRepo.dart';
import 'package:sintir/Core/repos/Test-Item-Repo/TestItemRepo.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionSolutionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/JoinedByEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/TestResulteEntity.dart';

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

  void uploadTestQuestionsImages({
    required Coursetestentity test,
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
    required Coursetestentity test,
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
        joinedbyentity: context.read<UserCubit>().getJoinedByEntity(),
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
    Either<Failure, void> result = await testitemrepo.addTestResult(
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

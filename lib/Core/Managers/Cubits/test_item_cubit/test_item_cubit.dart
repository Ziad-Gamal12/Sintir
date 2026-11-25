// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

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
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/JoinedByEntity.dart';
import 'package:sintir/Features/MyMistakes/Domain/Repo/MyMistakesRepo.dart';
import 'package:uuid/uuid.dart';

part 'test_item_state.dart';

class TestItemCubit extends Cubit<TestItemState> {
  TestItemCubit({
    required this.testitemrepo,
    required this.sectionItemsActionsRepo,
    required this.myMistakesRepo,
    required this.assetspickerrepo,
  }) : super(TestItemInitial());
  final Testitemrepo testitemrepo;
  final MyMistakesRepo myMistakesRepo;
  final SectionItemsActionsRepo sectionItemsActionsRepo;
  final Assetspickerrepo assetspickerrepo;

  /// One id for this sitting of the exam. A resend of the same attempt (the
  /// timer running out after a manual submit, a retry after a timeout) is
  /// stored once by the server instead of using up another attempt.
  final String submissionId = const Uuid().v4();
  bool _submitting = false;
  bool _submitted = false;

  void addNewQuestion({required CourseTestEntity coursetestentity}) {
    coursetestentity.addQuestion(null);
    emit(AddCourseSectionTestQuestionAdded());
  }

  void removeQuestion({
    required CourseTestEntity coursetestentity,
    required CourseTestQuestionEntity question,
  }) {
    coursetestentity.questions.remove(question);
    emit(AddCourseSectionTestQuestionRemoved());
  }

  void removeSolutin({
    required CourseTestQuestionSolutionEntity solution,
    required CourseTestEntity coursetestentity,
    required CourseTestQuestionEntity question,
  }) {
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

  void changeSelectedSolution({
    required CourseTestQuestionEntity question,
    required int index,
  }) {
    for (var solution in question.solutions) {
      solution.isCorrect = false;
    }
    question.solutions[index].isCorrect = true;

    emit(AddCourseSectionTestSolutionChanged());
  }

  Future<void> uploadTestQuestionsImages({
    required CourseTestEntity test,
  }) async {
    emit(QuestionsImagesUploadedingLoading());
    var resulte = await testitemrepo.uploadTestQuestionsImages(
      questions: test.questions,
    );
    resulte.fold(
      (failure) {
        emit(QuestionsImagesUploadedingFailure(errMessage: failure.message));
      },
      (success) {
        emit(QuestionsImagesUploadedingSuccuss());
      },
    );
  }

  Future<void> uploadTestQuestionsSolutionsImages({
    required CourseTestEntity test,
  }) async {
    emit(QuestionsSolutionsImagesUploadedingLoading());
    var resulte = await testitemrepo.uploadTestQuestionsSolutionsImages(
      questions: test.questions,
    );
    resulte.fold(
      (failure) {
        emit(
          QuestionsSolutionsImagesUploadedingFailure(
            errMessage: failure.message,
          ),
        );
      },
      (success) {
        emit(QuestionsSolutionsImagesUploadedingSuccuss());
      },
    );
  }

  void addTestItem({
    required String courseId,
    required String sectionId,
    required String teacherId,

    required CourseTestEntity test,
  }) async {
    emit(AddTestItemLoading());
    final result = await sectionItemsActionsRepo.addSectionItem(
      sectionItem: test,
      courseId: courseId,
      teacherId: teacherId,
      sectionId: sectionId,
    );
    result.fold(
      (failure) {
        emit(AddTestItemFailure(errMessage: failure.message));
      },
      (sucUpdateCourseSectionsFailurecess) {
        emit(AddTestItemSuccess());
      },
    );
  }

  /// Same scoring as the server: one point per answered question whose
  /// selected answer is a correct one.
  int getResult({required CourseTestEntity test}) {
    return getSolvedQuestions(test: test).where((q) => q.isCorrect).length;
  }

  /// The answered questions only (an empty selection is unanswered). A
  /// question without any correct option is graded wrong instead of throwing.
  List<ExamResultSolvedQuestionEntity> getSolvedQuestions({
    required CourseTestEntity test,
  }) {
    return [
      for (final CourseTestQuestionEntity question in test.questions)
        if ((question.selectedSolution ?? "").isNotEmpty)
          ExamResultSolvedQuestionEntity(
            question: question,
            isCorrect: question.solutions.any(
              (s) => s.isCorrect && s.answer == question.selectedSolution,
            ),
          ),
    ];
  }

  TestResultEntity prepareTestResultObject({
    required CourseTestEntity test,
    required String courseId,
    required String courseSubject,
    required String sectionId,
    required UserEntity user,
  }) {
    final solvedQuestions = getSolvedQuestions(test: test);
    final score = getResult(test: test);

    return TestResultEntity(
      isPassed: score >= (test.questions.length / 2),
      courseSubject: courseSubject,
      testName: test.title,
      joinedDate: DateTime.now(),
      serialNumber: "${DateTime.now().millisecondsSinceEpoch}-Result",
      testId: test.id,
      sectionId: sectionId,
      courseId: courseId,
      result: score,
      solvedQuestions: solvedQuestions.length,
      totalQuestions: test.questions.length,
      questionsSolvedListEntity: solvedQuestions,
      joinedbyentity: JoinedByEntity(
        uid: user.uid,
        name: user.fullName,
        imageUrl: user.profilePicurl,
        joinedDate: DateTime.now(),
      ),
    );
  }

  void addTestResults({
    required CourseTestEntity test,
    required String courseId,
    required String courseSubject,
    required String sectionId,
    required String sectionItemId,
    required bool isCourseExam,
    required String userId,
  }) async {
    // The submit button and the exam timer both call this; only one send may
    // be in flight, and none after the attempt is saved.
    if (_submitting || _submitted) return;
    _submitting = true;
    emit(AddTestResultLoading());
    try {
      if (isCourseExam) {
        final result = await testitemrepo.submitTestAttempt(
          courseId: courseId,
          sectionId: sectionId,
          test: test,
          submissionId: submissionId,
        );
        result.fold(
          (failure) => emit(AddTestResultFailure(errMessage: failure.message)),
          (testResult) {
            _submitted = true;
            emit(AddTestResultSuccess(result: testResult));
          },
        );
        return;
      }
      final testResult = prepareTestResultObject(
        test: test,
        courseId: courseId,
        courseSubject: courseSubject,
        sectionId: sectionId,
        user: getUserData(),
      );
      final result = await myMistakesRepo.storeTestMyMistakesExamResult(
        userUID: userId,
        testResult: testResult,
      );
      result.fold(
        (failure) => emit(AddTestResultFailure(errMessage: failure.message)),
        (_) {
          _submitted = true;
          emit(AddTestResultSuccess(result: testResult));
        },
      );
    } finally {
      _submitting = false;
    }
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
      sectionItemId: sectionItemId,
    );
    result.fold(
      (failure) {
        emit(JoinToTestItemFailure(errMessage: failure.message));
      },
      (sucUpdateCourseSectionsFailurecess) {
        emit(JoinToTestItemSuccess());
      },
    );
  }

  void resizeQuestionsImages({required String image, required bool isFilled}) {
    emit(ResizeQuestionsImageSuccess(imageUrl: image, isFilled: isFilled));
  }

  /// Points the question cards at [questions], which have no correct answer
  /// marked, so they can flag themselves and the first can scroll into view.
  void flagQuestionsMissingCorrectAnswer({
    required List<CourseTestQuestionEntity> questions,
  }) {
    emit(
      ExamQuestionsMissingCorrectAnswer(
        questions: List.unmodifiable(questions),
      ),
    );
  }

  /// Picks the image shown with [question] and stores it on the question.
  Future<void> pickQuestionImage({
    required CourseTestQuestionEntity question,
  }) async {
    emit(PickQuestionImageLoading(question: question));
    final result = await assetspickerrepo.pickImageFromGallery();
    if (isClosed) return;
    result.fold(
      (failure) {
        emit(
          PickQuestionImageFailure(
            question: question,
            errMessage: failure.message,
          ),
        );
      },
      (pickedImage) {
        question.imageFile = pickedImage;
        emit(PickQuestionImageSuccess(question: question, file: pickedImage));
      },
    );
  }

  /// Picks the image that explains [question]'s answer and stores it on the
  /// question.
  Future<void> pickQuestionSolutionImage({
    required CourseTestQuestionEntity question,
  }) async {
    emit(PickQuestionSolutionImageLoading(question: question));
    final result = await assetspickerrepo.pickImageFromGallery();
    if (isClosed) return;
    result.fold(
      (failure) {
        emit(
          PickQuestionSolutionImageFailure(
            question: question,
            errMessage: failure.message,
          ),
        );
      },
      (pickedImage) {
        question.solutionFile = pickedImage;
        emit(
          PickQuestionSolutionImageSuccess(
            question: question,
            file: pickedImage,
          ),
        );
      },
    );
  }
}

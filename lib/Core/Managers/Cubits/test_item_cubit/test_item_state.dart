part of 'test_item_cubit.dart';

@immutable
sealed class TestItemState {}

final class TestItemInitial extends TestItemState {}

final class AddCourseSectionTestQuestionAdded extends TestItemState {}

final class AddCourseSectionTestQuestionRemoved extends TestItemState {}

final class AddCourseSectionTestSolutionAdded extends TestItemState {}

final class AddCourseSectionTestSolutionRemoved extends TestItemState {}

final class AddCourseSectionTestSolutionChanged extends TestItemState {}

final class QuestionsImagesUploadedingLoading extends TestItemState {}

final class QuestionsImagesUploadedingFailure extends TestItemState {
  final String errMessage;
  QuestionsImagesUploadedingFailure({required this.errMessage});
}

final class QuestionsImagesUploadedingSuccuss extends TestItemState {}

final class QuestionsSolutionsImagesUploadedingLoading extends TestItemState {}

final class QuestionsSolutionsImagesUploadedingFailure extends TestItemState {
  final String errMessage;
  QuestionsSolutionsImagesUploadedingFailure({required this.errMessage});
}

final class QuestionsSolutionsImagesUploadedingSuccuss extends TestItemState {}

final class AddTestResultLoading extends TestItemState {}

final class AddTestResultFailure extends TestItemState {
  final String errMessage;
  AddTestResultFailure({required this.errMessage});
}

final class AddTestResultSuccess extends TestItemState {
  final TestResultEntity? result;
  AddTestResultSuccess({this.result});
}

final class JoinToTestItemFailure extends TestItemState {
  final String errMessage;
  JoinToTestItemFailure({required this.errMessage});
}

final class JoinToTestItemSuccess extends TestItemState {}

final class JoinToTestItemLoading extends TestItemState {}

final class AddTestItemLoading extends TestItemState {}

final class AddTestItemFailure extends TestItemState {
  final String errMessage;
  AddTestItemFailure({required this.errMessage});
}

final class AddTestItemSuccess extends TestItemState {}

final class ResizeQuestionsImageSuccess extends TestItemState {
  final bool isFilled;
  final String imageUrl;

  ResizeQuestionsImageSuccess({required this.isFilled, required this.imageUrl});
}

// Image picks carry the question they were started from: every question card
// listens to the same cubit, and only that question's card may react.

final class PickQuestionImageFailure extends TestItemState {
  final CourseTestQuestionEntity question;
  final String errMessage;
  PickQuestionImageFailure({required this.question, required this.errMessage});
}

final class PickQuestionImageSuccess extends TestItemState {
  final CourseTestQuestionEntity question;
  final File file;
  PickQuestionImageSuccess({required this.question, required this.file});
}

final class PickQuestionImageLoading extends TestItemState {
  final CourseTestQuestionEntity question;
  PickQuestionImageLoading({required this.question});
}

final class PickQuestionSolutionImageFailure extends TestItemState {
  final CourseTestQuestionEntity question;
  final String errMessage;
  PickQuestionSolutionImageFailure({
    required this.question,
    required this.errMessage,
  });
}

final class PickQuestionSolutionImageSuccess extends TestItemState {
  final CourseTestQuestionEntity question;
  final File file;
  PickQuestionSolutionImageSuccess({
    required this.question,
    required this.file,
  });
}

final class PickQuestionSolutionImageLoading extends TestItemState {
  final CourseTestQuestionEntity question;
  PickQuestionSolutionImageLoading({required this.question});
}

/// The teacher tried to leave the questions step while [questions] (in exam
/// order, never empty) have no correct answer marked. Those cards flag
/// themselves and the first one scrolls into view.
final class ExamQuestionsMissingCorrectAnswer extends TestItemState {
  final List<CourseTestQuestionEntity> questions;
  ExamQuestionsMissingCorrectAnswer({required this.questions});
}

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

final class AddTestResultLoading extends TestItemState {}

final class AddTestResultFailure extends TestItemState {
  final String errMessage;
  AddTestResultFailure({required this.errMessage});
}

final class AddTestResultSuccess extends TestItemState {}

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

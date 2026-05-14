part of 'get_my_mistakes_cubit.dart';

@immutable
sealed class GetMyMistakesState {}

final class GetMyMistakesInitial extends GetMyMistakesState {}

final class GetMyMistakesLoading extends GetMyMistakesState {
  final bool isPaginate;
  GetMyMistakesLoading({required this.isPaginate});
}

final class GetMyMistakesSuccess extends GetMyMistakesState {
  final List<QuestionMistakeEntity> myMistakesList;
  GetMyMistakesSuccess(
      {required this.myMistakesList, });
}

final class GetMyMistakesFailure extends GetMyMistakesState {
  final String errmessage;
  GetMyMistakesFailure({required this.errmessage});
}
final class CreateCustomExamLoading extends GetMyMistakesState {}
final class CreateCustomExamFailure extends GetMyMistakesState {
  final String errmessage;
  CreateCustomExamFailure({required this.errmessage});
}
final class CreateCustomExamSuccess extends GetMyMistakesState {
  final CourseExamViewNavigationsRequirmentsEntity requirements;
  CreateCustomExamSuccess({required this.requirements});
}

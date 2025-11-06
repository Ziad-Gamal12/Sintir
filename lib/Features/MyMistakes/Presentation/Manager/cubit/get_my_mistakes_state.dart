part of 'get_my_mistakes_cubit.dart';

@immutable
sealed class GetMyMistakesState {}

final class GetMyMistakesInitial extends GetMyMistakesState {}

final class GetMyMistakesLoading extends GetMyMistakesState {
  final bool isPaginate;
  GetMyMistakesLoading({required this.isPaginate});
}

final class GetMyMistakesSuccess extends GetMyMistakesState {
  final GetMyMistakesResponseEntity getMyMistakesResponseEntity;
  GetMyMistakesSuccess({required this.getMyMistakesResponseEntity});
}

final class GetMyMistakesFailure extends GetMyMistakesState {
  final String errmessage;
  GetMyMistakesFailure({required this.errmessage});
}

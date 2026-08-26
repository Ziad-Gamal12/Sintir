part of 'check_if_result_hidden_cubit.dart';

@immutable
sealed class CheckIfResultHiddenState {}

final class CheckIfResultHiddenInitial extends CheckIfResultHiddenState {}

final class CheckIfResultHiddenLoadingState extends CheckIfResultHiddenState {}

final class CheckIfResultHiddenSuccessState extends CheckIfResultHiddenState {
  final bool isHidden;
  CheckIfResultHiddenSuccessState({required this.isHidden});
}

final class CheckIfResultHiddenFailureState extends CheckIfResultHiddenState {
  final String message;
  CheckIfResultHiddenFailureState({required this.message});
}

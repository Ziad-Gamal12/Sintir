part of 'update_test_cubit.dart';

@immutable
sealed class UpdateTestState {}

final class UpdateTestInitial extends UpdateTestState {}

final class UpdateTestItemLoading extends UpdateTestState {}

final class UpdateTestItemSuccess extends UpdateTestState {}

final class UpdateTestItemFailure extends UpdateTestState {
  final String errMessage;
  UpdateTestItemFailure({required this.errMessage});
}

part of 'add_sql_test_cubit.dart';

@immutable
sealed class AddSQlTestState {}

final class AddSQlTestInitial extends AddSQlTestState {}

final class AddSQlTestQuestionAdded extends AddSQlTestState {}

final class AddSQlTestQuestionRemoved extends AddSQlTestState {}

final class AddSQlTestSolutionRemoved extends AddSQlTestState {}

final class AddSQlTestSolutionAdded extends AddSQlTestState {}

final class AddSQlTestSolutionChanged extends AddSQlTestState {}

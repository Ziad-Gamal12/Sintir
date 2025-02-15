part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class GetUserDataSuccess extends UserState {}

final class GetUserDataFailed extends UserState {
  final String message;
  GetUserDataFailed({required this.message});
}

final class GetUserDataLoading extends UserState {}

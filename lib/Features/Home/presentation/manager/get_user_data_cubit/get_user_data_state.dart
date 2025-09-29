part of 'get_user_data_cubit.dart';

@immutable
sealed class GetUserDataState {}

final class GetUserDataInitial extends GetUserDataState {}

final class GetUserDataSuccess extends GetUserDataState {}

final class GetUserDataFailure extends GetUserDataState {
  final String errmessage;
  GetUserDataFailure({required this.errmessage});
}

final class GetUserDataLoading extends GetUserDataState {}

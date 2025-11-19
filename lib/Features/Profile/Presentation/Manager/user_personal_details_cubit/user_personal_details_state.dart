part of 'user_personal_details_cubit.dart';

@immutable
sealed class UserPersonalDetailsState {}

final class UserPersonalDetailsInitial extends UserPersonalDetailsState {}

// update user profile pic state
final class UpdatedUserProfilePicSuccess extends UserPersonalDetailsState {}

final class UpdatedUserProfilePicFailure extends UserPersonalDetailsState {
  final String errMessage;
  UpdatedUserProfilePicFailure({required this.errMessage});
}

final class UpdatedUserProfilePicLoading extends UserPersonalDetailsState {}

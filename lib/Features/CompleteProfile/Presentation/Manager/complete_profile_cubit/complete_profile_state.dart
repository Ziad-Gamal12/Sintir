part of 'complete_profile_cubit.dart';

sealed class CompleteProfileState {
  const CompleteProfileState();
}

final class CompleteProfileInitial extends CompleteProfileState {
  const CompleteProfileInitial();
}

final class CompleteProfileSaving extends CompleteProfileState {
  const CompleteProfileSaving();
}

final class CompleteProfileSaved extends CompleteProfileState {
  const CompleteProfileSaved(this.user);
  final UserEntity user;
}

final class CompleteProfileFailure extends CompleteProfileState {
  const CompleteProfileFailure(this.message);
  final String message;
}

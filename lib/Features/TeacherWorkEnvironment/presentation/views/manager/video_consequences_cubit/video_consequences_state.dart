part of 'video_consequences_cubit.dart';

@immutable
sealed class VideoConsequencesState {}

final class VideoConsequencesInitial extends VideoConsequencesState {}
// getVideoNotes States



// getVideo Attended Count States
final class VideoConsequencesGetVideoAttendedCountLoading
    extends VideoConsequencesState {}

final class VideoConsequencesGetVideoAttendedCountFailure
    extends VideoConsequencesState {
  final String errMessage;

  VideoConsequencesGetVideoAttendedCountFailure({required this.errMessage});
}

final class VideoConsequencesGetVideoAttendedCountSuccess
    extends VideoConsequencesState {
  final int count;

  VideoConsequencesGetVideoAttendedCountSuccess({required this.count});
}

// get total students count
final class VideoConsequencesGetTotalStudentsCountLoading
    extends VideoConsequencesState {}

final class VideoConsequencesGetTotalStudentsCountFailure
    extends VideoConsequencesState {
  final String errMessage;

  VideoConsequencesGetTotalStudentsCountFailure({required this.errMessage});
}

final class VideoConsequencesGetTotalStudentsCountSuccess
    extends VideoConsequencesState {
  final int count;

  VideoConsequencesGetTotalStudentsCountSuccess({required this.count});
}

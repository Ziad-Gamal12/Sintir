part of 'video_consequences_cubit.dart';

@immutable
sealed class VideoConsequencesState {}

final class VideoConsequencesInitial extends VideoConsequencesState {}
// getVideoNotes States

final class VideoConsequencesGetVideoNotesLoading
    extends VideoConsequencesState {
  final bool isPaginate;

  VideoConsequencesGetVideoNotesLoading({required this.isPaginate});
}

final class VideoConsequencesGetVideoNotesFailure
    extends VideoConsequencesState {
  final String errmessage;

  VideoConsequencesGetVideoNotesFailure({required this.errmessage});
}

final class VideoConsequencesGetVideoNotesSuccess
    extends VideoConsequencesState {
  final GetVideoItemNotesResponseEntity response;

  VideoConsequencesGetVideoNotesSuccess({required this.response});
}

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

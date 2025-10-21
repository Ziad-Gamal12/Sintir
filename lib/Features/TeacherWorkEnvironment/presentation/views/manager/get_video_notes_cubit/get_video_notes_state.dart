part of 'get_video_notes_cubit.dart';

@immutable
sealed class GetVideoNotesState {}

final class GetVideoNotesInitial extends GetVideoNotesState {}

final class GetVideoNotesLoading extends GetVideoNotesState {
  final bool isPaginate;

  GetVideoNotesLoading({required this.isPaginate});
}

final class GetVideoNotesFailure extends GetVideoNotesState {
  final String errmessage;

  GetVideoNotesFailure({required this.errmessage});
}

final class GetVideoNotesSuccess extends GetVideoNotesState {
  final GetVideoItemNotesResponseEntity response;

  GetVideoNotesSuccess({required this.response});
}

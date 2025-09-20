part of 'video_item_cubit.dart';

@immutable
sealed class VideoItemState {}

final class VideoItemInitial extends VideoItemState {}

final class AddVideoItemLoading extends VideoItemState {}

final class AddVideoItemSuccess extends VideoItemState {}

final class AddVideoItemFailure extends VideoItemState {
  final String errMessage;
  AddVideoItemFailure({required this.errMessage});
}

final class PickVideoFileSuccess extends VideoItemState {
  final File file;
  PickVideoFileSuccess({required this.file});
}

final class PickVideoFileFailure extends VideoItemState {
  final String errMessage;
  PickVideoFileFailure({required this.errMessage});
}

final class UploadVideoLoading extends VideoItemState {}

final class UploadVideoSuccess extends VideoItemState {
  final String url;
  UploadVideoSuccess({required this.url});
}

final class UploadVideoFailure extends VideoItemState {
  final String errMessage;
  UploadVideoFailure({required this.errMessage});
}

final class JoinToVideoItemLoading extends VideoItemState {}

final class JoinToVideoItemSuccess extends VideoItemState {}

final class JoinToVideoItemFailure extends VideoItemState {
  final String errMessage;
  JoinToVideoItemFailure({required this.errMessage});
}

final class AddVideoNoteLoading extends VideoItemState {}

final class AddVideoNoteSuccess extends VideoItemState {}

final class AddVideoNoteFailure extends VideoItemState {
  final String errMessage;
  AddVideoNoteFailure({required this.errMessage});
}

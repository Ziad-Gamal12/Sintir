part of 'AddCourseSectionCubit.dart';

@immutable
sealed class AddCourseSectionState {}

final class AddCourseSectionInitial extends AddCourseSectionState {}

final class AddCourseSectionTestQuestionAdded extends AddCourseSectionState {}

final class AddCourseSectionTestQuestionRemoved extends AddCourseSectionState {}

final class AddCourseSectionTestSolutionRemoved extends AddCourseSectionState {}

final class AddCourseSectionTestSolutionAdded extends AddCourseSectionState {}

final class AddCourseSectionTestSolutionChanged extends AddCourseSectionState {}

final class AddCourseSectionTestQuestionUploadImageSuccess
    extends AddCourseSectionState {
  final String imageUrl;
  AddCourseSectionTestQuestionUploadImageSuccess({required this.imageUrl});
}

final class AddCourseSectionTestQuestionUploadImageLoading
    extends AddCourseSectionState {}

final class AddCourseSectionTestQuestionUploadImageFailure
    extends AddCourseSectionState {
  final String errMessage;
  AddCourseSectionTestQuestionUploadImageFailure({required this.errMessage});
}

final class UpdateCourseSectionsLoading extends AddCourseSectionState {}

final class UpdateCourseSectionsSuccess extends AddCourseSectionState {}

final class UpdateCourseSectionsFailure extends AddCourseSectionState {
  final String errMessage;
  UpdateCourseSectionsFailure({required this.errMessage});
}

final class AddCourseSectionVedioPicked extends AddCourseSectionState {
  final File videoFile;
  AddCourseSectionVedioPicked({required this.videoFile});
}

final class AddCourseSectionVedioUnPicked extends AddCourseSectionState {}

final class AddCourseSectionFilePicked extends AddCourseSectionState {
  final File file;
  AddCourseSectionFilePicked({required this.file});
}

final class AddCourseSectionFileUnPicked extends AddCourseSectionState {}

final class VideoUploadedingSuccuss extends AddCourseSectionState {
  final String url;
  VideoUploadedingSuccuss({required this.url});
}

final class VideoUploadedingFailure extends AddCourseSectionState {
  final String errMessage;
  VideoUploadedingFailure({required this.errMessage});
}

final class VideoUploadedingLoading extends AddCourseSectionState {}

final class FileUploadedingSuccuss extends AddCourseSectionState {
  final String url;
  FileUploadedingSuccuss({required this.url});
}

final class FileUploadedingFailure extends AddCourseSectionState {
  final String errMessage;
  FileUploadedingFailure({required this.errMessage});
}

final class FileUploadedingLoading extends AddCourseSectionState {}

final class QuestionsImagesUploadedingSuccuss extends AddCourseSectionState {}

final class QuestionsImagesUploadedingFailure extends AddCourseSectionState {
  final String errMessage;
  QuestionsImagesUploadedingFailure({required this.errMessage});
}

final class QuestionsImagesUploadedingLoading extends AddCourseSectionState {}

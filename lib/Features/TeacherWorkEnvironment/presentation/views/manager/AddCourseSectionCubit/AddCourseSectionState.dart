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

final class AddCourseSectionAddSectionLoading extends AddCourseSectionState {}

final class AddCourseSectionAddSectionSuccess extends AddCourseSectionState {}

final class AddCourseSectionAddSectionFailure extends AddCourseSectionState {
  final String errMessage;
  AddCourseSectionAddSectionFailure({required this.errMessage});
}

final class AddCourseSectionVedioPicked extends AddCourseSectionState {
  final File vedioFile;
  AddCourseSectionVedioPicked({required this.vedioFile});
}

final class AddCourseSectionVedioUnPicked extends AddCourseSectionState {}

final class AddCourseSectionFilePicked extends AddCourseSectionState {
  final File file;
  AddCourseSectionFilePicked({required this.file});
}

final class AddCourseSectionFileUnPicked extends AddCourseSectionState {}

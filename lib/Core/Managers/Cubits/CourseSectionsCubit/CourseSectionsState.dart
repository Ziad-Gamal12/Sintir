// ignore_for_file: file_names

part of 'CourseSectionsCubit.dart';

@immutable
sealed class CourseSectionsState {}

final class AddCourseSectionInitial extends CourseSectionsState {}

final class AddCourseSectionTestQuestionAdded extends CourseSectionsState {}

final class AddCourseSectionTestQuestionRemoved extends CourseSectionsState {}

final class AddCourseSectionTestSolutionRemoved extends CourseSectionsState {}

final class AddCourseSectionTestSolutionAdded extends CourseSectionsState {}

final class AddCourseSectionTestSolutionChanged extends CourseSectionsState {}

final class AddCourseSectionTestQuestionUploadImageSuccess
    extends CourseSectionsState {
  final String imageUrl;
  AddCourseSectionTestQuestionUploadImageSuccess({required this.imageUrl});
}

final class AddCourseSectionTestQuestionUploadImageLoading
    extends CourseSectionsState {}

final class AddCourseSectionTestQuestionUploadImageFailure
    extends CourseSectionsState {
  final String errMessage;
  AddCourseSectionTestQuestionUploadImageFailure({required this.errMessage});
}

final class UpdateCourseSectionsLoading extends CourseSectionsState {}

final class AddCourseSectionSuccess extends CourseSectionsState {}

final class AddCourseSectionFailure extends CourseSectionsState {
  final String errMessage;
  AddCourseSectionFailure({required this.errMessage});
}

final class AddCourseSectionVedioPicked extends CourseSectionsState {
  final File videoFile;
  AddCourseSectionVedioPicked({required this.videoFile});
}

final class AddCourseSectionVedioUnPicked extends CourseSectionsState {}

final class AddCourseSectionFilePicked extends CourseSectionsState {
  final File file;
  AddCourseSectionFilePicked({required this.file});
}

final class AddCourseSectionFileUnPicked extends CourseSectionsState {}

final class VideoUploadedingSuccuss extends CourseSectionsState {
  final String url;
  VideoUploadedingSuccuss({required this.url});
}

final class VideoUploadedingFailure extends CourseSectionsState {
  final String errMessage;
  VideoUploadedingFailure({required this.errMessage});
}

final class VideoUploadedingLoading extends CourseSectionsState {}

final class FileUploadedingSuccuss extends CourseSectionsState {
  final String url;
  FileUploadedingSuccuss({required this.url});
}

final class FileUploadedingFailure extends CourseSectionsState {
  final String errMessage;
  FileUploadedingFailure({required this.errMessage});
}

final class FileUploadedingLoading extends CourseSectionsState {}

final class QuestionsImagesUploadedingSuccuss extends CourseSectionsState {}

final class QuestionsImagesUploadedingFailure extends CourseSectionsState {
  final String errMessage;
  QuestionsImagesUploadedingFailure({required this.errMessage});
}

final class QuestionsImagesUploadedingLoading extends CourseSectionsState {}

final class GetCourseSectionsLoading extends CourseSectionsState {}

final class GetCourseSectionsSuccess extends CourseSectionsState {
  final List<CourseSectionEntity> sections;

  GetCourseSectionsSuccess({required this.sections});
}

final class GetCourseSectionsFailure extends CourseSectionsState {
  final String errMessage;
  GetCourseSectionsFailure({required this.errMessage});
}

final class AddCourseSectionItemFailure extends CourseSectionsState {
  final String errMessage;
  AddCourseSectionItemFailure({required this.errMessage});
}

final class AddCourseSectionItemSuccess extends CourseSectionsState {}

final class AddCourseSectionItemLoading extends CourseSectionsState {}

final class GetSectionItemsLoading extends CourseSectionsState {}

final class GetSectionItemsSuccess extends CourseSectionsState {
  final List items;
  final String sectionId;
  GetSectionItemsSuccess({required this.items, required this.sectionId});
}

final class GetSectionItemsFailure extends CourseSectionsState {
  final String errMessage;
  GetSectionItemsFailure({required this.errMessage});
}

final class AddJoinedByFailure extends CourseSectionsState {
  final String errMessage;
  AddJoinedByFailure({required this.errMessage});
}

final class AddJoinedBySuccess extends CourseSectionsState {}

final class AddJoinedByLoading extends CourseSectionsState {}

final class AddTestResultLoading extends CourseSectionsState {}

final class AddTestResultFailure extends CourseSectionsState {
  final String errMessage;
  AddTestResultFailure({required this.errMessage});
}

final class AddTestResultSuccess extends CourseSectionsState {}

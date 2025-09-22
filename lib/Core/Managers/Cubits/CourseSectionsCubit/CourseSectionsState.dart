// ignore_for_file: file_names

part of 'CourseSectionsCubit.dart';

@immutable
sealed class CourseSectionsState {}

final class AddCourseSectionInitial extends CourseSectionsState {}

final class AddCourseSectionSuccess extends CourseSectionsState {}

final class AddCourseSectionFailure extends CourseSectionsState {
  final String errMessage;
  AddCourseSectionFailure({required this.errMessage});
}

final class AddCourseSectionFilePicked extends CourseSectionsState {
  final File file;
  AddCourseSectionFilePicked({required this.file});
}

final class AddCourseSectionFileUnPicked extends CourseSectionsState {}

final class FileUploadedingSuccuss extends CourseSectionsState {
  final String url;
  FileUploadedingSuccuss({required this.url});
}

final class FileUploadedingFailure extends CourseSectionsState {
  final String errMessage;
  FileUploadedingFailure({required this.errMessage});
}

final class FileUploadedingLoading extends CourseSectionsState {}

final class GetCourseSectionsLoading extends CourseSectionsState {}

final class GetCourseSectionsSuccess extends CourseSectionsState {
  final GetCourseSectionsResonseEntity response;

  GetCourseSectionsSuccess({required this.response});
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

final class GetSectionItemsLoading extends CourseSectionsState {
  final String sectionId;
  GetSectionItemsLoading({required this.sectionId});
}

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

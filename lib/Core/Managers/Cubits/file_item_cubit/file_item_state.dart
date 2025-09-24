part of 'file_item_cubit.dart';

@immutable
sealed class FileItemState {}

final class FileItemInitial extends FileItemState {}

final class JoinToFileITemLoading extends FileItemState {}

final class JoinToFileITemSuccess extends FileItemState {}

final class JoinToFileITemFailure extends FileItemState {
  final String errMessage;
  JoinToFileITemFailure({required this.errMessage});
}

final class PickFileSuccess extends FileItemState {
  final File file;
  PickFileSuccess({required this.file});
}

final class PickFileFailure extends FileItemState {}

final class UplaodFileLoading extends FileItemState {}

final class UplaodFileSuccess extends FileItemState {
  final String url;
  UplaodFileSuccess({required this.url});
}

final class UplaodFileFailure extends FileItemState {
  final String errMessage;
  UplaodFileFailure({required this.errMessage});
}

final class AddFileItemLoading extends FileItemState {}

final class AddFileItemFailure extends FileItemState {
  final String errMessage;
  AddFileItemFailure({required this.errMessage});
}

final class AddFileItemSuccess extends FileItemState {}

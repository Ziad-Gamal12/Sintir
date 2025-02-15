// ignore_for_file: must_be_immutable

part of 'add_course_cubit.dart';

@immutable
sealed class AddCourseCubitState {}

final class AddCourseCubitInitial extends AddCourseCubitState {}

final class AddCourseCubitSuccess extends AddCourseCubitState {}

final class AddCourseCubitFailure extends AddCourseCubitState {
  final String errmessage;

  AddCourseCubitFailure(this.errmessage);
}

final class AddCourseCubitLoading extends AddCourseCubitState {}

final class AddCourseCubitAssetPicked extends AddCourseCubitState {
  File? file;

  AddCourseCubitAssetPicked({required this.file});
}

final class AddCourseCubitAssetLoading extends AddCourseCubitState {}

final class AddCourseCubitAssetFailure extends AddCourseCubitState {}

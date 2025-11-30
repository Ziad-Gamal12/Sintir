// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/models/contentCreaterModel.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/repos/CoursesRepo/CoursesRepo.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/locale_keys.dart';

part 'add_course_state.dart';

class AddCourseCubitCubit extends Cubit<AddCourseCubitState> {
  AddCourseCubitCubit({
    required this.coursesrepo,
    required this.assetspickerrepo,
  }) : super(AddCourseCubitInitial());
  final Coursesrepo coursesrepo;
  final Assetspickerrepo assetspickerrepo;
  File? coursePosterImage;
  addCourse(
      {required CourseEntity courseEntity,
      required UserEntity userEntity}) async {
    emit(AddCourseCubitLoading());
    try {
      courseEntity.contentcreaterentity =
          Contentcreatermodel.fromTeacherEntity(userEntity: userEntity)
              .toEntity();
      final posterResult =
          await coursesrepo.uplaodFile(file: coursePosterImage!);
      posterResult.fold((failure) {
        emit(AddCourseCubitFailure(failure.message));
      }, (url) async {
        courseEntity.posterUrl = url;
        final result = await coursesrepo.addCourse(courseEntity: courseEntity);
        result.fold((failure) => emit(AddCourseCubitFailure(failure.message)),
            (success) {
          emit(AddCourseCubitSuccess());
        });
      });
    } on Exception {
      emit(AddCourseCubitFailure(LocaleKeys.generalError));
    }
  }

  pickCoursePosterImage() async {
    emit(AddCourseCubitAssetLoading());
    final result = await assetspickerrepo.pickImageFromGallery();
    result.fold((failure) {
      emit(AddCourseCubitFailure(failure.message));
    }, (file) {
      coursePosterImage = file;
      emit(AddCourseCubitAssetPicked(file: coursePosterImage));
    });
  }
}

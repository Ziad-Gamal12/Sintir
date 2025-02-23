// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/models/contentCreaterModel.dart';
import 'package:sintir/Core/repos/CoursesRepo/CoursesRepo.dart';
import 'package:sintir/Core/services/PickerAssetsService.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Entities/teacherEntity.dart';

part 'add_course_state.dart';

class AddCourseCubitCubit extends Cubit<AddCourseCubitState> {
  AddCourseCubitCubit({
    required this.coursesrepo,
    required this.pickerassetsservice,
  }) : super(AddCourseCubitInitial());
  final Coursesrepo coursesrepo;
  final Pickerassetsservice pickerassetsservice;
  File? coursePosterImage;
  addCourse(
      {required CourseEntity courseEntity,
      teacherEntity? teacherentity}) async {
    emit(AddCourseCubitLoading());
    try {
      courseEntity.contentcreaterentity = Contentcreatermodel.fromTeacherEntity(
              teacherEntity: teacherentity ?? teacherentity!)
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
    } on Exception catch (e) {
      emit(AddCourseCubitFailure("حدث خطأ ما"));
    }
  }

  pickCoursePosterImage() async {
    emit(AddCourseCubitAssetLoading());
    try {
      coursePosterImage =
          await pickerassetsservice.getImage(source: ImageSource.gallery);
      coursePosterImage != null
          ? emit(AddCourseCubitAssetPicked(file: coursePosterImage))
          : null;
    } catch (e) {
      emit(AddCourseCubitFailure("حدث خطأ ما"));
    }
  }
}

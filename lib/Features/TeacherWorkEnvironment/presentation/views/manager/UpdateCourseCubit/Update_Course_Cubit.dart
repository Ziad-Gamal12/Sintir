import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/repos/CoursesRepo/CoursesRepo.dart';

part 'Update_Course_State.dart';

class UpdateCourseCubit extends Cubit<UpdateCourseState> {
  UpdateCourseCubit({required this.coursesrepo, required this.assetspickerrepo})
      : super(UpdateCourseInitial());
  final Coursesrepo coursesrepo;
  final Assetspickerrepo assetspickerrepo;
  File? coursePosterImage;

  void updateCourse({required CourseEntity courseEntity}) async {
    emit(UpdateCourseLoading());
    if (coursePosterImage != null) {
      final posterResult =
          await coursesrepo.uplaodFile(file: coursePosterImage!);
      posterResult.fold((failure) {
        emit(UpdateCourseFailure(failure.message));
      }, (url) async {
        courseEntity.posterUrl = url;
        final result =
            await coursesrepo.updateCourse(courseEntity: courseEntity);
        result.fold((failure) => emit(UpdateCourseFailure(failure.message)),
            (success) {
          emit(UpdateCourseSuccess());
        });
      });
    } else {
      final result = await coursesrepo.updateCourse(courseEntity: courseEntity);
      result.fold((failure) {
        emit(UpdateCourseFailure(failure.message));
      }, (success) {
        emit(UpdateCourseSuccess());
      });
    }
  }

  void pickCoursePosterImage() async {
    emit(UpdateCourseCubitAssetLoading());
    final result = await assetspickerrepo.pickImageFromGallery();
    result.fold((failure) {
      emit(UpdateCourseCubitAssetFailure(failure.message));
    }, (file) {
      coursePosterImage = file;
      emit(UpdateCourseCubitAssetPicked(file: file));
    });
  }
}

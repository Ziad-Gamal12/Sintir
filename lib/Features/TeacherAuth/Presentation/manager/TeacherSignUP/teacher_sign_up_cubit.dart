// ignore_for_file: avoid_types_as_parameter_names, depend_on_referenced_packages

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/services/PickerAssetsService.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Entities/teacherEntity.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Repos/repos.dart';

part 'teacher_sign_up_state.dart';

class TeacherSignUpCubit extends Cubit<TeacherSignUpState> {
  TeacherSignUpCubit(this.teacherAuthRepos, this.pickerassetsservice)
      : super(TeacherSignUpInitial());
  final TeacherAuthRepos teacherAuthRepos;
  final Pickerassetsservice pickerassetsservice;
  File? imageFile;
  Future<void> createUserWithEmailAndPassword({
    required teacherEntity teacherentity,
    required String password,
  }) async {
    emit(TeacherSignUpLoading());
    teacherAuthRepos.uploadProfilePoc(image: imageFile!).then((value) {
      value.fold((failure) {
        emit(TeacherSignUpFailure(errmessage: failure.message));
      }, (url) {
        teacherentity.profilePicurl = url;
        teacherAuthRepos
            .createUserWithEmailAndPassword(
                teacherEntity: teacherentity, password: password)
            .then((value) {
          value.fold((failure) {
            emit(TeacherSignUpFailure(errmessage: failure.message));
          }, (value) {
            emit(TeacherSignUpSuccess());
          });
        });
      });
    });
  }

  Future<void> pickTeacherProfilePic({required ImageSource source}) async {
    File? image = await pickerassetsservice.getImage(source: source);
    imageFile = image;
    emit(PickTeacherProfilePicSuccess());
  }
}

// ignore_for_file: avoid_types_as_parameter_names, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Entities/Teacher_Entity.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Repos/repos.dart';

part 'teacher_sign_up_state.dart';

class TeacherSignUpCubit extends Cubit<TeacherSignUpState> {
  TeacherSignUpCubit(this.teacherAuthRepos) : super(TeacherSignUpInitial());
  final TeacherAuthRepos teacherAuthRepos;
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String firstName,
    required String lastName,
    required String address,
    required String phoneNumber,
    required String subject,
    required String workExperience,
    required String gender,
    required String profilePicurl,
    required String state,
  }) async {
    emit(TeacherSignUpLoading());
    var result = await teacherAuthRepos.createUserWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
        firstName: firstName,
        lastName: lastName,
        address: address,
        phoneNumber: phoneNumber,
        subject: subject,
        workExperience: workExperience,
        gender: gender,
        profilePicurl: profilePicurl,
        state: state);
    result.fold((failure) {
      emit(TeacherSignUpFailure(errmessage: failure.message));
    }, (teacherEntity) {
      emit(TeacherSignUpSuccess(TeacherEntity: teacherEntity));
    });
  }

  Future<void> uploadTeacherProfilePicture(
      {required ImageSource source}) async {
    emit(UploadTeacherProfilePictureLoading());
    var result = await teacherAuthRepos.uploadProfilePoc(source: source);
    result.fold((failure) {
      emit(UploadTeacherProfilePictureFailure(errmessage: failure.message));
    }, (url) {
      emit(UploadTeacherProfilePictureSuccess(url: url));
    });
  }
}

// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/repos/CoursesRepo/CoursesRepo.dart';
import 'package:sintir/Core/repos/UserRepos/userRepo.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/JoinedByEntity.dart';
import 'package:sintir/Features/StudenetAuth/domain/entities/studentEntity.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Entities/teacherEntity.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required this.userrepo, required this.coursesrepo})
      : super(UserInitial());
  final Userrepo userrepo;
  teacherEntity? teacherentity;
  Studententity? studententity;
  final Coursesrepo coursesrepo;
  Future<void> getUsersCourses() async {
    emit(GetMyCourseLoading());
    var result = await coursesrepo.getMyCourses();
    result.fold((failure) {
      emit(GetMyCourseFailure(errMessage: failure.message));
    }, (courses) {
      emit(GetMyCourseSuccess(courses: courses));
    });
  }

  Future<void> getUserData() async {
    emit(GetUserDataLoading());
    final resulte = await userrepo.getUserData();
    resulte.fold((failure) {
      emit(GetUserDataFailed(message: failure.message));
    }, (userEntity) {
      if (userEntity.teacher != null) {
        teacherentity = userEntity.teacher;
      } else {
        studententity = userEntity.student;
      }
      emit(GetUserDataSuccess());
    });
  }

  JoinedByEntity getJoinedByEntity() {
    if (teacherentity != null) {
      return JoinedByEntity(
        imageUrl: teacherentity!.profilePicurl!,
        name: teacherentity!.firstName,
        joinedDate: DateTime.now(),
        uid: teacherentity!.uid!,
      );
    } else if (studententity != null) {
      return JoinedByEntity(
        imageUrl: studententity!.imageUrl,
        name: studententity!.firstName,
        joinedDate: DateTime.now(),
        uid: studententity!.uid!,
      );
    } else {
      return JoinedByEntity(
        imageUrl: "",
        name: "غير معروف",
        joinedDate: DateTime.now(),
        uid: "",
      );
    }
  }
}

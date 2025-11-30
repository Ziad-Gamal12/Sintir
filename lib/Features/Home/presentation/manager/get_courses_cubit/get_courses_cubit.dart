import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetCourseResonseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/CoursesRepo/CoursesRepo.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';

part 'get_courses_state.dart';

class GetCoursesCubit extends Cubit<GetCoursesState> {
  GetCoursesCubit({required this.coursesrepo}) : super(GetCoursesInitial());
  final Coursesrepo coursesrepo;
  Future<void> getRecentCourses({required bool isPaginate}) async {
    emit(GetRecentCoursesLoading(
      isPaginate: isPaginate,
    ));
    final result = await coursesrepo.getRecentCourses(
      isPaginate: isPaginate,
    );
    result.fold(
        (failure) => emit(GetRecentCoursesFailure(errmessage: failure.message)),
        (response) => emit(GetRecentCoursesSuccess(resonseEntity: response)));
  }

  Future<void> getPopularCourses({required bool isPaginate}) async {
    emit(GetPopularCoursesLoading(
      isPaginate: isPaginate,
    ));
    final result = await coursesrepo.getPopularCourses(
      isPaginate: isPaginate,
    );
    result.fold(
        (failure) =>
            emit(GetPopularCoursesFailure(errmessage: failure.message)),
        (response) => emit(GetPopularCoursesSuccess(resonseEntity: response)));
  }

  Future<void> getUserInterestedCourses(
      {required bool isPaginate, required UserEntity user}) async {
    emit(GetUserInerestCoursesLoading(
      isPaginate: isPaginate,
    ));
    Either<Failure, GetCoursesResonseEntity>? result;
    if (user.role == BackendEndpoints.teacherRole) {
      result = await coursesrepo.getTeaceherInterestedCourses(
        isPaginate: isPaginate,
        subject: user.teacherExtraDataEntity?.subject ?? "",
      );
    } else if (user.role == BackendEndpoints.studentRole) {
      result = await coursesrepo.getStudentInterestedCourses(
        isPaginate: isPaginate,
        educationlevel: user.studentExtraDataEntity?.educationLevel ?? "",
      );
    }

    result?.fold(
        (failure) =>
            emit(GetUserInerestCoursesFailure(errmessage: failure.message)),
        (response) =>
            emit(GetUserInerestCoursesSuccess(resonseEntity: response)));
  }
}

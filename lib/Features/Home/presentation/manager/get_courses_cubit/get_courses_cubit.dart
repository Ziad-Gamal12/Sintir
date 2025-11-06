import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetCourseResonseEntity.dart';
import 'package:sintir/Core/repos/CoursesRepo/CoursesRepo.dart';

part 'get_courses_state.dart';

class GetCoursesCubit extends Cubit<GetCoursesState> {
  GetCoursesCubit({required this.coursesrepo}) : super(GetCoursesInitial());
  final Coursesrepo coursesrepo;
  Future<void> getRecentCourses({required bool isPaginate}) async {
    emit(GetRecentCoursesLoading());
    final result = await coursesrepo.getRecentCourses(
      isPaginate: isPaginate,
    );
    result.fold(
        (failure) => emit(GetRecentCoursesFailure(errmessage: failure.message)),
        (response) => emit(GetRecentCoursesSuccess(resonseEntity: response)));
  }

  handleRefresh() async {
    Future.delayed(const Duration(seconds: 2), () {
      getRecentCourses(
        isPaginate: false,
      );
      getPopularCourses(
        isPaginate: false,
      );
    });
  }

  Future<void> getPopularCourses({required bool isPaginate}) async {
    emit(GetPopularCoursesLoading());
    final result = await coursesrepo.getPopularCourses(
      isPaginate: isPaginate,
    );
    result.fold(
        (failure) =>
            emit(GetPopularCoursesFailure(errmessage: failure.message)),
        (response) => emit(GetPopularCoursesSuccess(resonseEntity: response)));
  }
}

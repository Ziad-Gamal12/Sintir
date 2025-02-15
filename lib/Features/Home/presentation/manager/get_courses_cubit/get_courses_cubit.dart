import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/repos/CoursesRepo/CoursesRepo.dart';

part 'get_courses_state.dart';

class GetCoursesCubit extends Cubit<GetCoursesState> {
  GetCoursesCubit({required this.coursesrepo}) : super(GetCoursesInitial());
  final Coursesrepo coursesrepo;
  getRecentCourses() async {
    emit(GetCoursesloading());
    final result = await coursesrepo.getRecentCourses();
    result.fold(
        (failure) => emit(GetCoursesFailure(errmessage: failure.message)),
        (courses) => emit(GetCoursesSuccess(courses: courses)));
  }
}

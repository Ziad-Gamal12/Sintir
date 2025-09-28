import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/GetCourseResonseEntity.dart';
import 'package:sintir/Core/repos/CoursesRepo/CoursesRepo.dart';

part 'ProfileState.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.coursesrepo}) : super(GetMyCoursesInitial());
  final Coursesrepo coursesrepo;

  Future<void> getMyCourses({required bool isPaginate}) async {
    emit(GetMyCoursesLoading(
      isPaginate: isPaginate,
    ));
    final result = await coursesrepo.getMyCourses(isPaginate: isPaginate);
    result.fold(
        (failure) => emit(GetMyCoursesFailure(errmessage: failure.message)),
        (response) => emit(
            GetMyCoursesSuccess(response: response, isPaginate: isPaginate)));
  }
}

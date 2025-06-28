import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/repos/CoursesRepo/CoursesRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/UpdateCourseCubit/Update_Course_State.dart';

class UpdateCourseCubit extends Cubit<UpdateCourseState> {
  UpdateCourseCubit({required this.coursesrepo}) : super(UpdateCourseInitial());
  final Coursesrepo coursesrepo;
  updateCourse({required CourseEntity courseEntity}) async {
    emit(UpdateCourseLoading());
    final result = await coursesrepo.updateCourse(courseEntity: courseEntity);
    result.fold((failure) {
      emit(UpdateCourseFailure(failure.message));
    }, (success) {
      emit(UpdateCourseSuccess());
    });
  }
}

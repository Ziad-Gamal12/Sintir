import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/GetCourseReportsResponseEntity.dart';
import 'package:sintir/Core/repos/CourseReportsRepo/CourseReportsRepo.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseReportsItemEntity.dart';

part 'course_reports_state.dart';

class CourseReportsCubit extends Cubit<CourseReportsState> {
  CourseReportsCubit({required this.coursereportsrepo})
      : super(CourseReportsInitial());
  final CourseReportsRepo coursereportsrepo;
  Future<void> getCourseReports(
      {required String courseId, required bool isPaginate}) async {
    emit(CourseReportsGetReportLoading());
    final result = await coursereportsrepo.getCourseReports(
        courseId: courseId, isPaginate: isPaginate);
    result.fold((failure) {
      emit(CourseReportsGetReportFailure(errMessage: failure.message));
    }, (courseReports) {
      emit(CourseReportsGetReportSuccess(response: courseReports));
    });
  }

  Future<void> addCourseReport(
      {required String courseId,
      required CourseReportEntity reportEntity}) async {
    emit(CourseReportsAddReportLoading());
    final result = await coursereportsrepo.addCourseReport(
        courseId: courseId, reportEntity: reportEntity);
    result.fold((failure) {
      emit(CourseReportsAddReportFailure(errMessage: failure.message));
    }, (success) {
      emit(CourseReportsAddReportSuccess());
    });
  }
}

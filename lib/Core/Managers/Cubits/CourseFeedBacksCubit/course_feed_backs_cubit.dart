import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/repos/CourseFeedBacksRepo/CourseFeedBacksRepo.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursefedbackItemEntity.dart';

part 'course_feed_backs_state.dart';

class CourseFeedBacksCubit extends Cubit<CourseFeedBacksState> {
  CourseFeedBacksCubit({required this.courseFeedBacksRepo})
      : super(CourseFeedBacksInitial());
  final CourseFeedBacksRepo courseFeedBacksRepo;

  Future<void> getCourseFeedBacks({required String courseId}) async {
    emit(CourseFeedBacksGetFeedBackLoading());
    final result =
        await courseFeedBacksRepo.getCourseFedBacks(courseId: courseId);
    result.fold((failure) {
      emit(CourseFeedBacksGetFeedBackFailure(errMessage: failure.message));
    }, (success) {
      emit(CourseFeedBacksGetFeedBackSuccess(feedBacks: success));
    });
  }

  Future<void> addCourseFeedBack(
      {required String courseId,
      required CoursefeedbackItemEntity feedback}) async {
    emit(CourseFeedBacksAddFeedBackLoading());
    final result = await courseFeedBacksRepo.addCourseFedBack(
        courseId: courseId, review: feedback);
    result.fold((failure) {
      emit(CourseFeedBacksAddFeedBackFailure(errMessage: failure.message));
    }, (success) {
      emit(CourseFeedBacksAddFeedBackSuccess());
    });
  }
}

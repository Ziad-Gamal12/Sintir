import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/GetVideoItemNotesResponseEntity.dart';
import 'package:sintir/Core/repos/CourseSubscibtionsRepo/CourseSubscibtionsRepo.dart';
import 'package:sintir/Core/repos/Video-Item-Repo/VideoItemRepo.dart';

part 'video_consequences_state.dart';

class VideoConsequencesCubit extends Cubit<VideoConsequencesState> {
  VideoConsequencesCubit(
      {required this.videoItemRepo, required this.subscibtionsRepo})
      : super(VideoConsequencesInitial());
  final CourseSubscibtionsRepo subscibtionsRepo;
  final VideoItemRepo videoItemRepo;
  Future<void> getVideoItemNotes(
      {required String courseId,
      required String sectionId,
      required String videoId,
      required bool isPaginate}) async {
    emit(VideoConsequencesGetVideoNotesLoading(isPaginate: isPaginate));
    final result = await videoItemRepo.getVideoItemNotes(
        courseId: courseId,
        sectionId: sectionId,
        videoId: videoId,
        isPaginate: isPaginate);
    result.fold((failure) {
      emit(VideoConsequencesGetVideoNotesFailure(errmessage: failure.message));
    }, (success) {
      emit(VideoConsequencesGetVideoNotesSuccess(response: success));
    });
  }

  Future<void> getTotalStudentsCount({
    required String courseId,
  }) async {
    emit(VideoConsequencesGetTotalStudentsCountLoading());
    final result =
        await subscibtionsRepo.getSubscribersCount(courseID: courseId);
    result.fold((failure) {
      emit(VideoConsequencesGetTotalStudentsCountFailure(
          errMessage: failure.message));
    }, (success) {
      emit(VideoConsequencesGetTotalStudentsCountSuccess(count: success));
    });
  }

  Future<void> getVideoAttendedCount({
    required String courseId,
    required String sectionId,
    required String videoId,
  }) async {
    emit(VideoConsequencesGetVideoAttendedCountLoading());
    final result = await videoItemRepo.getAttendedCount(
        courseId: courseId, sectionId: sectionId, videoId: videoId);
    result.fold((failure) {
      emit(VideoConsequencesGetVideoAttendedCountFailure(
          errMessage: failure.message));
    }, (success) {
      emit(VideoConsequencesGetVideoAttendedCountSuccess(count: success));
    });
  }
}

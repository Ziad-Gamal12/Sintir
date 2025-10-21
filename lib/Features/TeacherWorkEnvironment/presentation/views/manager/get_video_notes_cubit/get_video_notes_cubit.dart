import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/GetVideoItemNotesResponseEntity.dart';
import 'package:sintir/Core/repos/Video-Item-Repo/VideoItemRepo.dart';

part 'get_video_notes_state.dart';

class GetVideoNotesCubit extends Cubit<GetVideoNotesState> {
  GetVideoNotesCubit({required this.videoItemRepo})
      : super(GetVideoNotesInitial());
  final VideoItemRepo videoItemRepo;
  Future<void> getVideoItemNotes(
      {required String courseId,
      required String sectionId,
      required String videoId,
      required bool isPaginate}) async {
    emit(GetVideoNotesLoading(isPaginate: isPaginate));
    final result = await videoItemRepo.getVideoItemNotes(
        courseId: courseId,
        sectionId: sectionId,
        videoId: videoId,
        isPaginate: isPaginate);
    result.fold((failure) {
      emit(GetVideoNotesFailure(errmessage: failure.message));
    }, (success) {
      emit(GetVideoNotesSuccess(response: success));
    });
  }
}

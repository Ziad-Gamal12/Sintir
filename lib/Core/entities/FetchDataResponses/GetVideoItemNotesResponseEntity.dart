import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/VideoNoteEntity.dart';

class GetVideoItemNotesResponseEntity {
  final List<VideoNoteEntity> notes;
  final bool hasMore;
  final bool isPaginate;

  GetVideoItemNotesResponseEntity(
      {required this.notes, required this.hasMore, required this.isPaginate});
}

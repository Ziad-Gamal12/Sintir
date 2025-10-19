import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/VideoNoteEntity.dart';

class GetVideoItemNotesResponseEntity {
  final List<VideoNoteEntity> notes;
  final bool hasMore;
  final bool isPaginate;

  GetVideoItemNotesResponseEntity(
      {required this.notes, required this.hasMore, required this.isPaginate});
}

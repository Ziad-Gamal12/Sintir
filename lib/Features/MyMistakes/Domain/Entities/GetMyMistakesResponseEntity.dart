import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/QuestionMistakeEntity.dart';

class GetMyMistakesResponseEntity {
  final List<QuestionMistakeEntity> myMistakesList;
  final bool hasMore;
  final bool isPaginate;
  GetMyMistakesResponseEntity({
    required this.myMistakesList,
    required this.hasMore,
    required this.isPaginate,
  });
}

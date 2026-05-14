part of 'create_my_exam_bloc.dart';

@immutable
sealed class CreateMyExamEvent {}

final class GetSubjectsMistakesCountEvent extends CreateMyExamEvent {
  final String subjectId;
  final String userUID;
  GetSubjectsMistakesCountEvent(
      {required this.subjectId, required this.userUID});
}

final class GetAllSubjectsMistakesCountEvent extends CreateMyExamEvent {
  final List<String> subjectIds;
  final String userUID;
  GetAllSubjectsMistakesCountEvent(
      {required this.subjectIds, required this.userUID});
}

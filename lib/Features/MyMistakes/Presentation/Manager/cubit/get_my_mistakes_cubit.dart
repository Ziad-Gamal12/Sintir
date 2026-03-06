import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestViewNavigationsRequirmentsEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/MistakeProgressEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/QuestionMistakeEntity.dart';
import 'package:sintir/Features/MyMistakes/Domain/Repo/MyMistakesRepo.dart';
import 'package:uuid/uuid.dart';

part 'get_my_mistakes_state.dart';

class GetMyMistakesCubit extends Cubit<GetMyMistakesState> {
  GetMyMistakesCubit({required this.myMistakesRepo})
      : super(GetMyMistakesInitial());

  final MyMistakesRepo myMistakesRepo;

  // Data Storage
  List<QuestionMistakeEntity> myMistakes = [];
  Map<String, List<QuestionMistakeEntity>> groupedMistakes = {};
  bool hasMore = true;

  // --- 1. Fetching Logic ---

  Future<void> getMyMistakes(
      {required String userUID, required bool isPaginate}) async {
    emit(GetMyMistakesLoading(isPaginate: isPaginate));

    final result = await myMistakesRepo.getMyMistakes(
        userUID: userUID, isPaginate: isPaginate);

    result.fold(
      (failure) => emit(GetMyMistakesFailure(errmessage: failure.message)),
      (data) {
        if (isPaginate) {
          myMistakes.addAll(data.myMistakesList);
        } else {
          myMistakes = data.myMistakesList;
        }
        hasMore = data.hasMore;
        _groupMistakesBySubject();

        emit(GetMyMistakesSuccess(
          myMistakesList: List.from(myMistakes),
          groupedMistakes: Map.from(groupedMistakes),
        ));
      },
    );
  }

  void _groupMistakesBySubject() {
    groupedMistakes = MistakeGrouping(myMistakes).groupByCourseSubject();
  }

  void createOwnExam({
    int questionLimit = 20,
    String? courseSubject,
  }) {
    List<QuestionMistakeEntity> sourceList = courseSubject == null
        ? myMistakes
        : (groupedMistakes[courseSubject] ?? []);

    List<CourseTestQuestionEntity> examQuestions = sourceList
        .where((e) =>
            e.progress.status == MistakeStatus.active ||
            e.progress.status == MistakeStatus.improving)
        .map((e) => e.question.question)
        .toList();

    examQuestions.shuffle();

    if (examQuestions.length > questionLimit) {
      examQuestions = examQuestions.sublist(0, questionLimit);
    }

    if (examQuestions.isEmpty) {
      emit(GetMyMistakesFailure(
          errmessage: "لا يوجد أسئلة متاحة حالياً لإنشاء إمتحان"));
      return;
    }

    final requirements = CourseExamViewNavigationsRequirmentsEntity(
      courseId: "",
      isCourseExam: false,
      courseSubject: courseSubject ?? "",
      sectionId: "",
      test: CourseTestEntity(
        id: const Uuid().v4(),
        questions: examQuestions,
        title: courseSubject == null
            ? "إمتحان شامل للأخطاء"
            : "مراجعة أخطاء في $courseSubject",
        durationTime: _calculateSmartDuration(examQuestions.length),
        showResult: true,
        numberOfAttempts: null,
      ),
    );
    emit(CreateCustomExamSuccess(requirements: requirements));
  }

  int _calculateSmartDuration(int questionCount) {
    return questionCount * 2;
  }
}

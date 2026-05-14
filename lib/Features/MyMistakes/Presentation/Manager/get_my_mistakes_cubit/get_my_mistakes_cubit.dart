import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestViewNavigationsRequirmentsEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/MistakeProgressEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/QuestionMistakeEntity.dart';
import 'package:sintir/Features/MyMistakes/Domain/Repo/MyMistakesRepo.dart';
import 'package:sintir/locale_keys.dart';
import 'package:uuid/uuid.dart';

part 'get_my_mistakes_state.dart';

class GetMyMistakesCubit extends Cubit<GetMyMistakesState> {
  GetMyMistakesCubit({required this.myMistakesRepo})
      : super(GetMyMistakesInitial());

  final MyMistakesRepo myMistakesRepo;

  // Data Storage
  List<QuestionMistakeEntity> myMistakes = [];
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
        emit(GetMyMistakesSuccess(
          myMistakesList: List.from(myMistakes),
        ));
      },
    );
  }

  void createOwnExam({
    int questionLimit = 20,
    String? courseSubject,
    required String userUID,
  }) async {
    emit(CreateCustomExamLoading());

    final result = await myMistakesRepo.getAllActiveMistakes(userUID: userUID);

    result.fold(
      (failure) => emit(CreateCustomExamFailure(errmessage: failure.message)),
      (allMistakes) {
        // 1. Filter by subject
        List<QuestionMistakeEntity> filteredList = courseSubject == null
            ? allMistakes
            : allMistakes
                .where((m) => m.courseSubject == courseSubject)
                .toList();

        // 2. Filter by status (Only Active/Improving - never Mastered)
        List<CourseTestQuestionEntity> examQuestions = filteredList
            .where((e) =>
                e.progress.status == MistakeStatus.active ||
                e.progress.status == MistakeStatus.improving)
            .map((e) => e.question.question)
            .toList();

        // 3. Logic Safety Check
        if (examQuestions.isEmpty) {
          emit(
              CreateCustomExamFailure(errmessage: LocaleKeys.errorNoQuestions));
          return;
        }

        // 4. Randomize and Limit
        examQuestions.shuffle();
        if (examQuestions.length > questionLimit) {
          examQuestions = examQuestions.sublist(0, questionLimit);
        }

        // 5. Build Localized Title
        final String examTitle = courseSubject == null
            ? LocaleKeys.generalExamTitle
            : LocaleKeys.subjectExamTitle;

        // 6. Build Requirements
        final requirements = CourseExamViewNavigationsRequirmentsEntity(
          courseId: "",
          isCourseExam: false,
          courseSubject: courseSubject ?? "General",
          sectionId: "",
          test: CourseTestEntity(
            id: const Uuid().v4(),
            questions: examQuestions,
            title: examTitle,
            durationTime: _calculateSmartDuration(examQuestions.length),
            showResult: true,
            numberOfAttempts: null,
          ),
        );

        emit(CreateCustomExamSuccess(requirements: requirements));
      },
    );
  }

  int _calculateSmartDuration(int questionCount) {
    return questionCount * 2;
  }
}

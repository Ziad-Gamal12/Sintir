import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestViewNavigationsRequirmentsEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/MistakeProgressEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/QuestionMistakeEntity.dart';
import 'package:sintir/Features/MyMistakes/Domain/Entities/GetMyMistakesResponseEntity.dart';
import 'package:sintir/Features/MyMistakes/Domain/Repo/MyMistakesRepo.dart';
import 'package:uuid/uuid.dart';

part 'get_my_mistakes_state.dart';

class GetMyMistakesCubit extends Cubit<GetMyMistakesState> {
  GetMyMistakesCubit({required this.myMistakesRepo})
      : super(GetMyMistakesInitial());
  final MyMistakesRepo myMistakesRepo;
  List<QuestionMistakeEntity> myMistakes = [];
  List<CourseTestQuestionEntity> myMistakesActiveQuestions = [];
  Future<void> getMyMistakes(
      {required String userUID, required bool isPaginate}) async {
    emit(GetMyMistakesLoading(
      isPaginate: isPaginate,
    ));
    final result = await myMistakesRepo.getMyMistakes(
        userUID: userUID, isPaginate: isPaginate);
    result.fold(
        (failure) => emit(GetMyMistakesFailure(
              errmessage: failure.message,
            )), (data) {
      if (isPaginate) {
        myMistakes.addAll(data.myMistakesList);
      } else {
        myMistakes = data.myMistakesList;
      }
      getMyExamQuestions();
      emit(GetMyMistakesSuccess(getMyMistakesResponseEntity: data));
    });
  }

  CourseExamViewNavigationsRequirmentsEntity
      getCreatingMyExamRequirmentsEntity() {
    return CourseExamViewNavigationsRequirmentsEntity(
        courseId: "",
        isCourseExam: false,
        sectionId: "",
        test: CourseTestEntity(
            id: const Uuid().v4(),
            questions: myMistakesActiveQuestions,
            title: "إمتحانك الخاص",
            durationTime: 60,
            showResult: true,
            numberOfAttempts: null));
  }

  void getMyExamQuestions() {
    myMistakesActiveQuestions = myMistakes
        .map((e) => e)
        .where((e) =>
            e.progress.status == MistakeStatus.active ||
            e.progress.status == MistakeStatus.improving)
        .map((e) => e.question.question)
        .toList();
  }
}

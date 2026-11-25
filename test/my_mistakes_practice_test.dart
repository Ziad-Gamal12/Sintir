import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionSolutionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/MistakeProgressEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/QuestionMistakeEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/repos/SectionItemsActionsRepo/SectionItemsActionRepo.dart';
import 'package:sintir/Core/repos/Test-Item-Repo/TestItemRepo.dart';
import 'package:sintir/Features/MyMistakes/Domain/Repo/MyMistakesRepo.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Manager/get_my_mistakes_cubit/get_my_mistakes_cubit.dart';

class _Unused
    implements
        Testitemrepo,
        SectionItemsActionsRepo,
        MyMistakesRepo,
        Assetspickerrepo {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeMistakesRepo implements MyMistakesRepo {
  _FakeMistakesRepo(this.mistakes);
  final List<QuestionMistakeEntity> mistakes;

  @override
  Future<Either<Failure, List<QuestionMistakeEntity>>> getAllActiveMistakes({
    required String userUID,
  }) async =>
      Right(mistakes);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

CourseTestQuestionEntity _question(
  String id, {
  String? correct,
  String selected = "",
}) =>
    CourseTestQuestionEntity(
      questionId: id,
      questionTitle: 'Q $id',
      isOpened: false,
      selectedSolution: selected,
      solutions: [
        for (final answer in ['a', 'b', 'c'])
          CourseTestQuestionSolutionEntity(
            answer: answer,
            isCorrect: answer == correct,
          ),
      ],
    );

QuestionMistakeEntity _mistake(CourseTestQuestionEntity question) =>
    QuestionMistakeEntity(
      question: ExamResultSolvedQuestionEntity(
        question: question,
        isCorrect: false,
      ),
      progress: MistakeProgressEntity(
        questionId: question.questionId,
        lastAnsweredAt: DateTime(2026, 11, 20),
        wrongCount: 1,
      ),
      courseId: 'course-1',
      sectionId: 'section-1',
      courseSubject: 'Math',
    );

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('practice grading', () {
    final unused = _Unused();
    final cubit = TestItemCubit(
      testitemrepo: unused,
      sectionItemsActionsRepo: unused,
      myMistakesRepo: unused,
      assetspickerrepo: unused,
    );
    tearDownAll(cubit.close);

    CourseTestEntity exam(List<CourseTestQuestionEntity> questions) =>
        CourseTestEntity(
          durationTime: 4,
          title: 'Practice',
          questions: questions,
          numberOfAttempts: null,
          showResult: true,
          id: 'practice',
        );

    test('a question without a correct option is graded wrong, not thrown',
        () {
      final test = exam([_question('q1', selected: 'a')]);
      final solved = cubit.getSolvedQuestions(test: test);
      expect(solved.single.isCorrect, isFalse);
      expect(cubit.getResult(test: test), 0);
    });

    test('unanswered questions are not counted as solved or wrong', () {
      final test = exam([
        _question('q1', correct: 'b', selected: 'b'),
        _question('q2', correct: 'a', selected: 'c'),
        _question('q3', correct: 'a'),
      ]);
      final solved = cubit.getSolvedQuestions(test: test);
      expect(solved.map((q) => q.question.questionId), ['q1', 'q2']);
      expect(solved.map((q) => q.isCorrect), [true, false]);
      expect(cubit.getResult(test: test), 1);
    });
  });

  group('creating a practice exam', () {
    test('starts clean and leaves out questions that cannot be graded',
        () async {
      final stored = _question('q1', correct: 'b', selected: 'a');
      final cubit = GetMyMistakesCubit(
        myMistakesRepo: _FakeMistakesRepo([
          _mistake(stored),
          _mistake(_question('q2', selected: 'a')),
        ]),
      );
      cubit.createOwnExam(userUID: 'student-1');
      await pumpEventQueue();

      final state = cubit.state as CreateCustomExamSuccess;
      final question = state.requirements.test.questions.single;
      expect(question.questionId, 'q1');
      expect(question.selectedSolution, '', reason: 'old wrong answer cleared');
      expect(question.isOpened, isFalse);
      expect(stored.selectedSolution, 'a', reason: 'stored mistake untouched');
      await cubit.close();
    });

    test('fails clearly when no mistake can be practised', () async {
      final cubit = GetMyMistakesCubit(
        myMistakesRepo: _FakeMistakesRepo([
          _mistake(_question('q2', selected: 'a')),
        ]),
      );
      cubit.createOwnExam(userUID: 'student-1');
      await pumpEventQueue();
      expect(cubit.state, isA<CreateCustomExamFailure>());
      await cubit.close();
    });
  });
}

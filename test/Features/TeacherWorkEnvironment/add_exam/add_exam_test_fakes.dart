import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionSolutionEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/repos/CourseSectionsRepos/CourseSectionsRepo.dart';
import 'package:sintir/Core/repos/SectionItemsActionsRepo/SectionItemsActionRepo.dart';
import 'package:sintir/Core/repos/Test-Item-Repo/TestItemRepo.dart';
import 'package:sintir/Features/MyMistakes/Domain/Repo/MyMistakesRepo.dart';

class FakeTestItemRepo implements Testitemrepo {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeSectionItemsActionsRepo implements SectionItemsActionsRepo {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeMyMistakesRepo implements MyMistakesRepo {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeCourseSectionsRepo implements CourseSectionsRepo {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// Hands out [file] for every gallery pick, or fails when it is null.
class FakeAssetsPickerRepo implements Assetspickerrepo {
  FakeAssetsPickerRepo({this.file});

  final File? file;

  @override
  Future<Either<Failure, File>> pickImageFromGallery() async {
    final picked = file;
    if (picked == null) return left(ServerFailure(message: 'cancelled'));
    return right(picked);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

TestItemCubit buildTestItemCubit({File? pickedFile}) => TestItemCubit(
  testitemrepo: FakeTestItemRepo(),
  sectionItemsActionsRepo: FakeSectionItemsActionsRepo(),
  myMistakesRepo: FakeMyMistakesRepo(),
  assetspickerrepo: FakeAssetsPickerRepo(file: pickedFile),
);

CourseTestQuestionEntity buildQuestion({
  String title = 'Question',
  List<String> answers = const ['A', 'B'],
  int? correctIndex,
}) => CourseTestQuestionEntity(
  questionId: title,
  isOpened: false,
  questionTitle: title,
  solutions: [
    for (final (index, answer) in answers.indexed)
      CourseTestQuestionSolutionEntity(
        answer: answer,
        isCorrect: index == correctIndex,
      ),
  ],
);

CourseTestEntity buildExam(List<CourseTestQuestionEntity> questions) =>
    CourseTestEntity(
      durationTime: 30,
      title: 'Exam',
      questions: questions,
      numberOfAttempts: null,
      showResult: true,
      id: 'exam',
    );

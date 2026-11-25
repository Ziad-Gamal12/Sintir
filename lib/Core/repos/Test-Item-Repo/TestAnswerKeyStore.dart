// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/locale_keys.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/data/models/CourseTestModel.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/data/models/CoursetestquestionModel.dart';

class TestAnswerKeyStore {
  TestAnswerKeyStore({FirebaseFirestore? firestore}) : _firestore = firestore;

  final FirebaseFirestore? _firestore;

  FirebaseFirestore get _db => _firestore ?? FirebaseFirestore.instance;

  DocumentReference<Map<String, dynamic>> _itemRef({
    required String courseId,
    required String sectionId,
    required String testId,
  }) {
    return _db
        .collection(BackendEndpoints.coursesCollection)
        .doc(courseId)
        .collection(BackendEndpoints.sectionsSubCollection)
        .doc(sectionId)
        .collection(BackendEndpoints.sectionItemsSubCollection)
        .doc(testId);
  }

  DocumentReference<Map<String, dynamic>> _keyRef({
    required String courseId,
    required String sectionId,
    required String testId,
  }) {
    return _itemRef(
      courseId: courseId,
      sectionId: sectionId,
      testId: testId,
    )
        .collection(BackendEndpoints.testPrivateSubCollection)
        .doc(BackendEndpoints.testAnswerKeyDoc);
  }

  Future<void> saveTest({
    required String courseId,
    required String sectionId,
    required CourseTestEntity test,
  }) async {
    // The answer key is what the server grades with. A question without a
    // correct option marks every answer wrong and turns into a mistake the
    // student can never practise, so such a test is never saved. This also
    // stops an edit from overwriting the key when the teacher's copy was
    // loaded without its answers.
    final missing = test.questionsWithoutCorrectAnswer;
    if (missing.isNotEmpty) {
      throw CustomException(
        message: LocaleKeys.missingCorrectAnswers('${missing.length}'),
      );
    }
    final model = Coursetestmodel.fromEntity(test);
    final batch = _db.batch();
    batch.set(
      _keyRef(courseId: courseId, sectionId: sectionId, testId: test.id),
      model.toAnswerKeyJson(),
    );
    batch.set(
      _itemRef(courseId: courseId, sectionId: sectionId, testId: test.id),
      model.toPublicJson(),
    );
    await batch.commit();
  }

  Future<void> deleteTest({
    required String courseId,
    required String sectionId,
    required String testId,
  }) async {
    final batch = _db.batch();
    batch.delete(
      _keyRef(courseId: courseId, sectionId: sectionId, testId: testId),
    );
    batch.delete(
      _itemRef(courseId: courseId, sectionId: sectionId, testId: testId),
    );
    await batch.commit();
  }

  Future<void> deleteAnswerKey({
    required String courseId,
    required String sectionId,
    required String testId,
  }) {
    return _keyRef(
      courseId: courseId,
      sectionId: sectionId,
      testId: testId,
    ).delete();
  }

  Future<void> fillAnswers({
    required String courseId,
    required String sectionId,
    required CourseTestEntity test,
  }) async {
    final snapshot = await _keyRef(
      courseId: courseId,
      sectionId: sectionId,
      testId: test.id,
    ).get();
    final questions = snapshot.data()?['questions'];
    if (questions is! List) return;
    test.questions
      ..clear()
      ..addAll(
        questions.whereType<Map>().map(
              (question) => CourseTestQuestionModel.fromJson(
                Map<String, dynamic>.from(question),
              ).toEntity(),
            ),
      );
  }
}

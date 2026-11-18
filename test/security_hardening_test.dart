import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionSolutionEntity.dart';
import 'package:sintir/Core/repos/CourseCouponsRepo/CourseCouponsRepoImp.dart';
import 'package:sintir/Core/repos/File-Item-Repo/FileItemRepoImpli.dart';
import 'package:sintir/Core/repos/Test-Item-Repo/TestItemRepo-Impli.dart';
import 'package:sintir/Core/services/SupabaseStorageServices.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/utils/SupabaseBuckets.dart';
import 'package:sintir/Features/Auth/Data/repos/AuthRepoImpl.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/data/models/CourseTestModel.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/data/models/CoursetestquestionsolutionModel.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/UpdateCourseCubit/Update_Course_Cubit.dart';

CourseTestEntity _test() => CourseTestEntity(
      id: 't1',
      title: 'Quiz',
      durationTime: 10,
      numberOfAttempts: 2,
      showResult: true,
      questions: [
        CourseTestQuestionEntity(
          questionId: 'q1',
          questionTitle: '2 + 2',
          isOpened: false,
          solutionImageUrl: 'https://example.com/why.png',
          solutions: [
            CourseTestQuestionSolutionEntity(answer: '3', isCorrect: false),
            CourseTestQuestionSolutionEntity(answer: '4', isCorrect: true),
          ],
        ),
      ],
    );

void main() {
  group('test answer keys', () {
    test('the student-readable test has no correct flags or explanations', () {
      final json = Coursetestmodel.fromEntity(_test()).toPublicJson();
      final question = (json['questions'] as List).single as Map;

      expect(json['questionsCount'], 1);
      expect(question.containsKey('solutionUrl'), isFalse);
      expect(question['solutions'], [
        {'answer': '3'},
        {'answer': '4'},
      ]);
      expect(json.toString().contains('isCorrect'), isFalse);
    });

    test('the answer key keeps everything the teacher entered', () {
      final json = Coursetestmodel.fromEntity(_test()).toAnswerKeyJson();
      final question = (json['questions'] as List).single as Map;

      expect(json['testId'], 't1');
      expect(question['solutionUrl'], 'https://example.com/why.png');
      expect((question['solutions'] as List).last, {
        'answer': '4',
        'isCorrect': true,
      });
    });

    test('public questions parse without correct flags', () {
      final solution = Coursetestquestionsolutionmodel.fromJson({
        'answer': '4',
      });

      expect(solution.isCorrect, isFalse);
    });
  });

  test('server results with ISO dates become result entities', () {
    final result = TestItemRepoImpli.resultFromServer({
      'serialNumber': 'student-attempt-1',
      'joinedDate': '2026-11-18T10:00:00.000Z',
      'totalQuestions': 3,
      'solvedQuestions': 2,
      'isPassed': true,
      'result': 2,
      'courseId': 'c1',
      'sectionId': 's1',
      'testId': 't1',
      'testName': 'Quiz',
      'courseSubject': 'Math',
      'joinedby': {
        'uid': 'student',
        'name': 'Sara',
        'imageUrl': '',
        'joinedDate': '2026-11-18T10:00:00.000Z',
      },
      'questionsSolvedList': [
        {
          'isCorrect': true,
          'question': {
            'questionId': 'q1',
            'questionTitle': '2 + 2',
            'isOpened': false,
            'imageUrl': null,
            'solutionUrl': null,
            'selectedSolution': '4',
            'solutions': [
              {'answer': '4', 'isCorrect': true},
            ],
          },
        },
      ],
    });

    expect(result.serialNumber, 'student-attempt-1');
    expect(result.result, 2);
    expect(result.joinedbyentity.uid, 'student');
    expect(result.joinedDate.toUtc(), DateTime.utc(2026, 11, 18, 10));
    expect(result.questionsSolvedListEntity.single.isCorrect, isTrue);
  });

  test('saving course edits sends the course to review', () {
    expect(
      UpdateCourseCubit.stateAfterEdit(BackendEndpoints.coursePublishedState),
      BackendEndpoints.coursePendingState,
    );
    expect(
      UpdateCourseCubit.stateAfterEdit(BackendEndpoints.coursedeclinedState),
      BackendEndpoints.coursePendingState,
    );
    expect(
      UpdateCourseCubit.stateAfterEdit(
        BackendEndpoints.courseDeletedByAdminState,
      ),
      BackendEndpoints.courseDeletedByAdminState,
    );
  });

  test('profile updates never send role, status or the wallet', () {
    final data = AuthRepoImpl.editableProfileFields({
      'uid': 'u1',
      'fullName': 'New',
      'role': 'Admin',
      'status': 'Active',
      'deviceId': 'd1',
      'joinedDate': DateTime(2026),
      'teacherExtraData': {
        'subject': 'Math',
        'workExperience': '3',
        'wallet': {'balance': 1},
      },
    });

    expect(data.keys, containsAll(['fullName', 'teacherExtraData.subject']));
    expect(data.containsKey('role'), isFalse);
    expect(data.containsKey('status'), isFalse);
    expect(data.containsKey('uid'), isFalse);
    expect(data.containsKey('teacherExtraData'), isFalse);
    expect(data.toString().contains('wallet'), isFalse);
  });

  test('coupon edits leave usage counters to the server', () {
    final data = CourseCouponsRepoImp.editableCouponFields({
      'code': 'SAVE10',
      'discountPercentage': 10.0,
      'usageLimit': 5,
      'usedCount': 0,
      'status': 'active',
    });

    expect(data.keys.toSet(), {'discountPercentage', 'usageLimit', 'status'});
  });

  test('uploads ask the server for a slot by purpose', () {
    expect(
      SupabaseStorageServices.uploadPurposeFor(SupabaseBuckets.Users.name),
      'avatar',
    );
    expect(
      SupabaseStorageServices.uploadPurposeFor(SupabaseBuckets.Support.name),
      'support',
    );
    expect(
      SupabaseStorageServices.uploadPurposeFor(SupabaseBuckets.Courses.name),
      'course_media',
    );
  });

  test('only legacy file links skip the signed-url request', () {
    expect(FileItemRepoImpli.isPublicFileUrl('https://x/y.pdf'), isTrue);
    expect(FileItemRepoImpli.isPublicFileUrl('course-1/abc.pdf'), isFalse);
  });
}

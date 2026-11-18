import 'package:dartz/dartz.dart';
import 'package:sintir/Core/Enums/CourseCouponEnum.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseRatingStatsEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CoursefedbackItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherCourseActivity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherCoursesQuery.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/TeacherWorkspaceRepo.dart';

final workspaceNow = DateTime(2026, 11, 18, 12);

String get published => BackendEndpoints.coursePublishedState;
String get pending => BackendEndpoints.coursePendingState;
String get declined => BackendEndpoints.coursedeclinedState;
String get archived => BackendEndpoints.courseDeletedState;

CourseEntity workspaceCourse(
  String id, {
  String? state,
  String? title,
  int students = 0,
  int lessons = 3,
  int tests = 1,
  int ratingsSum = 0,
  int ratingsCount = 0,
  int price = 100,
  DateTime? posted,
}) {
  return CourseEntity(
    id: id,
    state: state ?? published,
    title: title ?? 'Course $id',
    description: '',
    language: 'العربية',
    subject: 'Math',
    level: '1st Grade Primary',
    price: price,
    studentsCount: students,
    lessonsCount: lessons,
    testsCount: tests,
    feedBacksCount: ratingsCount,
    postedDate: posted ?? DateTime(2026, 1, 1),
    ratingStats: CourseRatingStatsEntity(
      ratingsSum: ratingsSum,
      ratingsCount: ratingsCount,
    ),
  );
}

CoursefeedbackItemEntity workspaceReview(
  String uid, {
  int? rating,
  int daysAgo = 1,
  String text = '',
}) {
  return CoursefeedbackItemEntity(
    userImage: '',
    name: 'Student $uid',
    uid: uid,
    fedBack: text,
    datePosted: workspaceNow.subtract(Duration(days: daysAgo)),
    rating: rating,
  );
}

CourseCouponEntity workspaceCoupon(
  String code, {
  int daysLeft = 30,
  int limit = 0,
  int used = 0,
  CourseCouponStatus status = CourseCouponStatus.active,
}) {
  return CourseCouponEntity(
    code: code,
    discountPercentage: 20,
    expiryDate: DateTime(
      workspaceNow.year,
      workspaceNow.month,
      workspaceNow.day + daysLeft,
    ),
    status: status,
    usageLimit: limit,
    usedCount: used,
  );
}

class FakeWorkspaceRepo implements TeacherWorkspaceRepo {
  FakeWorkspaceRepo({
    List<CourseEntity> courses = const [],
    Map<String, TeacherCourseActivity> activities = const {},
    this.sort = TeacherCoursesSort.newest,
  }) : courses = List.of(courses),
       activities = Map.of(activities);

  List<CourseEntity> courses;
  Map<String, TeacherCourseActivity> activities;
  TeacherCoursesSort sort;
  String? coursesFailure;
  String? activityFailure;
  int coursesCalls = 0;
  final List<String> activityCalls = [];
  final List<TeacherCoursesSort> savedSorts = [];

  @override
  Future<Either<Failure, List<CourseEntity>>> getCourses({
    required String teacherId,
  }) async {
    coursesCalls++;
    final failure = coursesFailure;
    if (failure != null) return left(ServerFailure(message: failure));
    return right(List.of(courses));
  }

  @override
  Future<Either<Failure, TeacherCourseActivity>> getCourseActivity({
    required CourseEntity course,
    required DateTime now,
  }) async {
    activityCalls.add(course.id);
    final failure = activityFailure;
    if (failure != null) return left(ServerFailure(message: failure));
    return right(
      activities[course.id] ?? TeacherCourseActivity(courseId: course.id),
    );
  }

  @override
  TeacherCoursesSort savedSort() => sort;

  @override
  Future<void> saveSort(TeacherCoursesSort sort) async {
    savedSorts.add(sort);
    this.sort = sort;
  }
}

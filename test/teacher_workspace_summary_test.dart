import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Core/Enums/CourseCouponEnum.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherAttentionItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherCourseActivity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherEarningsPolicy.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherWorkspaceSummary.dart';

import 'teacher_workspace_test_data.dart';

void main() {
  test('net earnings keep 95% like the payment webhook', () {
    expect(TeacherEarningsPolicy.teacherShare, 0.95);
    expect(TeacherEarningsPolicy.netFromGross(1000), 950);
    expect(TeacherEarningsPolicy.netFromGross(150.5), 142.98);
    expect(TeacherEarningsPolicy.netFromGross(0), 0);
  });

  test('KPIs add every course and its 30 day activity', () {
    final summary = TeacherWorkspaceSummary.build(
      courses: [
        workspaceCourse(
          'a',
          students: 20,
          ratingsSum: 9,
          ratingsCount: 2,
        ),
        workspaceCourse(
          'b',
          state: archived,
          students: 5,
          ratingsSum: 8,
          ratingsCount: 2,
        ),
        workspaceCourse('c', state: pending),
        CourseEntity.empty(),
      ],
      activities: const [
        TeacherCourseActivity(
          courseId: 'a',
          newStudents: 6,
          previousNewStudents: 2,
          grossRevenue: 1000,
        ),
        TeacherCourseActivity(
          courseId: 'b',
          newStudents: 1,
          grossRevenue: 150.5,
        ),
      ],
      now: workspaceNow,
    );

    final kpis = summary.kpis;
    expect(kpis.newStudents, 7);
    expect(kpis.previousNewStudents, 2);
    expect(kpis.studentsChange, 5);
    expect(kpis.netEarnings, 1092.98);
    expect(kpis.ratingsCount, 4);
    expect(kpis.averageRating, 4.25);
    expect(kpis.totalStudents, 25);
    expect(kpis.publishedCourses, 1);
    expect(summary.attention, isEmpty);
  });

  test('attention lists declined, reports, low ratings, then coupons', () {
    final a = workspaceCourse('a');
    final b = workspaceCourse('b');
    final c = workspaceCourse('c', state: 'Rejected');
    final d = workspaceCourse('d', state: 'Archived');
    final summary = TeacherWorkspaceSummary.build(
      courses: [a, b, c, d],
      activities: [
        TeacherCourseActivity(
          courseId: 'a',
          openReports: 2,
          coupons: [
            workspaceCoupon('SOON', daysLeft: 1),
            workspaceCoupon('ALMOST', limit: 20, used: 18),
            workspaceCoupon('HEALTHY', limit: 100, used: 5),
            workspaceCoupon(
              'OFF',
              daysLeft: 1,
              status: CourseCouponStatus.inactive,
            ),
            workspaceCoupon('GONE', daysLeft: -1),
            workspaceCoupon('FULL', limit: 10, used: 10),
          ],
        ),
        TeacherCourseActivity(
          courseId: 'b',
          recentReviews: [
            workspaceReview('old-low', rating: 2, daysAgo: 4),
            workspaceReview('happy', rating: 5, daysAgo: 1),
            workspaceReview('angry', rating: 1, daysAgo: 2),
            workspaceReview('legacy', daysAgo: 1),
          ],
        ),
      ],
      now: workspaceNow,
    );

    expect(summary.attention.map((item) => item.kind), [
      TeacherAttentionKind.declined,
      TeacherAttentionKind.adminHidden,
      TeacherAttentionKind.openReports,
      TeacherAttentionKind.lowRatings,
      TeacherAttentionKind.couponEnding,
      TeacherAttentionKind.couponEnding,
    ]);
    expect(summary.attention[0].course.id, 'c');
    expect(summary.attention[1].course.id, 'd');
    expect(summary.attention[2].count, 2);
    expect(summary.attention[3].count, 2);
    expect(summary.attention[3].review?.uid, 'angry');
    expect(summary.attention[4].coupon?.code, 'SOON');
    expect(summary.attention[4].couponDaysLeft, 1);
    expect(summary.attention[5].coupon?.code, 'ALMOST');
    expect(summary.attention[5].couponDaysLeft, isNull);
    expect(summary.openReportsFor('a'), 2);
    expect(summary.openReportsFor('b'), 0);
  });

  test('a coupon is ending near its expiry or its last uses', () {
    bool ending(int daysLeft, {int limit = 0, int used = 0}) =>
        TeacherWorkspaceSummary.isCouponEnding(
          workspaceCoupon('X', daysLeft: daysLeft, limit: limit, used: used),
          workspaceNow,
        );

    expect(ending(0), isTrue);
    expect(ending(3), isTrue);
    expect(ending(4), isFalse);
    expect(ending(-1), isFalse);
    expect(ending(30, limit: 100, used: 90), isTrue);
    expect(ending(30, limit: 100, used: 89), isFalse);
    expect(ending(30, limit: 5, used: 3), isTrue);
    expect(ending(30, limit: 5, used: 5), isFalse);
    expect(
      TeacherWorkspaceSummary.couponDaysLeft(
        workspaceCoupon('X', daysLeft: 2),
        workspaceNow,
      ),
      2,
    );
  });
}

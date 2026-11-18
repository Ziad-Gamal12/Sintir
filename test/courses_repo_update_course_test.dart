import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Core/entities/CourseEntities/ContentCreaterEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseRatingStatsEntity.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/repos/CoursesRepo/CoursesRepo_impl.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/services/StorageService.dart';

class _Write {
  _Write(this.data, this.requirements);
  final Map<String, dynamic> data;
  final FireStoreRequirmentsEntity requirements;
}

class _RecordingDatabase implements DataBaseService {
  final List<_Write> updates = [];

  @override
  Future<void> updateData({
    required dynamic data,
    required FireStoreRequirmentsEntity requirements,
    String? field,
  }) async {
    updates.add(_Write(Map<String, dynamic>.from(data as Map), requirements));
  }

  @override
  Future<void> setData({
    required Map<String, dynamic> data,
    required FireStoreRequirmentsEntity requirements,
  }) async {
    fail('updateCourse must not re-write whole course documents.');
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _UnusedStorage implements StorageService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  test('editing a course updates only the fields a teacher edits', () async {
    final database = _RecordingDatabase();
    final repo = CoursesrepoImpl(
      databaseservice: database,
      storageService: _UnusedStorage(),
    );
    final course = CourseEntity.empty()
      ..id = 'course-1'
      ..title = 'New title'
      ..contentcreaterentity = Contentcreaterentity(
        name: 'Mohamed Ashref',
        profileImageUrl: '',
        id: 'teacher-1',
        title: 'Math teacher',
      );
    // A stale copy of the course: these values must not reach Firestore.
    final stale = CourseEntity(
      id: course.id,
      state: course.state,
      title: course.title,
      description: course.description,
      price: course.price,
      language: course.language,
      subject: course.subject,
      level: course.level,
      posterUrl: course.posterUrl,
      postedDate: course.postedDate,
      contentcreaterentity: course.contentcreaterentity,
      studentsCount: 0,
      lessonsCount: 0,
      testsCount: 0,
      feedBacksCount: 0,
      ratingStats: const CourseRatingStatsEntity(),
    );

    final result = await repo.updateCourse(courseEntity: stale);

    expect(result.isRight(), isTrue);
    expect(database.updates, hasLength(2));
    for (final write in database.updates) {
      expect(write.data.keys.toSet(), {
        'title',
        'description',
        'posterUrl',
        'price',
        'language',
        'subject',
        'level',
        'state',
      });
      expect(write.data['title'], 'New title');
    }
    expect(database.updates[0].requirements.collection, 'Courses');
    expect(database.updates[0].requirements.docId, 'course-1');
    expect(database.updates[1].requirements.collection, 'Users');
    expect(database.updates[1].requirements.docId, 'teacher-1');
    expect(database.updates[1].requirements.subCollection, 'Courses');
    expect(database.updates[1].requirements.subDocId, 'course-1');
  });
}

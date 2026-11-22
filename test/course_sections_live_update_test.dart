import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localingo/localingo.dart';
import 'package:sintir/Core/Enums/courseCounterField.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/Themes/app_theme.dart';
import 'package:sintir/Core/entities/CourseEntities/ContentCreaterEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/course_content_changes.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetCourseSectionsResonseEntity.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/CourseCountersRepo/CourseCountersRepo.dart';
import 'package:sintir/Core/repos/CourseSectionsRepos/CourseSectionsRepo.dart';
import 'package:sintir/Core/repos/CourseSectionsRepos/CourseSectionsRepo_impl.dart';
import 'package:sintir/Core/repos/SectionItemsActionsRepo/SectionItemsActionRepo.dart';
import 'package:sintir/Core/repos/SectionItemsActionsRepo/SectionItemsActionRepoImpli.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseFileEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CourseDetailsCourseSectionsViewBody.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/empty_section_message.dart';

import 'helpers/widget_test_helpers.dart';

CourseSectionEntity _section(String id, String title) =>
    CourseSectionEntity(id: id, title: title, subtitle: '$title subtitle');

CourseFileEntity _file(String id, String title) => CourseFileEntity(
  id: id,
  title: title,
  description: '$title description',
  fileUrl: 'https://example.com/$id.pdf',
);

CourseEntity _course(String id) => CourseEntity.empty()
  ..id = id
  ..contentcreaterentity = Contentcreaterentity(
    name: 'Teacher',
    profileImageUrl: '',
    id: 'teacher-1',
    title: 'Math teacher',
  );

/// Stands in for Firestore: the list screen reads from it and the add screens
/// write to it, and each successful write is published like the real repos do.
class _FakeSectionsRepo implements CourseSectionsRepo {
  _FakeSectionsRepo(this.sections);

  final List<CourseSectionEntity> sections;
  final _added = StreamController<AddedCourseSection>.broadcast();
  int fetches = 0;

  @override
  Stream<AddedCourseSection> get addedSections => _added.stream;

  @override
  Future<Either<Failure, void>> addCourseSection({
    required CourseSectionEntity section,
    required String courseId,
  }) async {
    sections.add(section);
    _added.add(AddedCourseSection(courseId: courseId, section: section));
    return const Right(null);
  }

  @override
  Future<Either<Failure, GetCourseSectionsResonseEntity>> getCourseSections({
    required String courseId,
    required bool isPaginate,
  }) async {
    fetches++;
    return Right(
      GetCourseSectionsResonseEntity(
        sections: List.of(sections),
        hasMore: false,
        isPaginate: isPaginate,
      ),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeItemsRepo implements SectionItemsActionsRepo {
  _FakeItemsRepo(this.itemsBySection);

  final Map<String, List<dynamic>> itemsBySection;
  final _added = StreamController<AddedSectionItem>.broadcast();
  int fetches = 0;

  @override
  Stream<AddedSectionItem> get addedItems => _added.stream;

  @override
  Future<Either<Failure, void>> addSectionItem({
    required dynamic sectionItem,
    required String teacherId,
    required String courseId,
    required String sectionId,
  }) async {
    itemsBySection.putIfAbsent(sectionId, () => []).add(sectionItem);
    _added.add(
      AddedSectionItem(
        courseId: courseId,
        sectionId: sectionId,
        item: sectionItem,
      ),
    );
    return const Right(null);
  }

  @override
  Future<Either<Failure, List>> getSectionsItems({
    required String courseId,
    required String sectionId,
  }) async {
    fetches++;
    return Right(List.of(itemsBySection[sectionId] ?? const []));
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Database implements DataBaseService {
  _Database({this.failWrites = false});

  final bool failWrites;
  final List<FireStoreRequirmentsEntity> writes = [];

  @override
  Future<void> setData({
    required Map<String, dynamic> data,
    required FireStoreRequirmentsEntity requirements,
  }) async {
    if (failWrites) throw CustomException(message: 'offline');
    writes.add(requirements);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Counters implements CourseCountersRepo {
  @override
  Future<void> updateCourseCounters({
    required String courseId,
    required String teacherId,
    required CourseCounterField field,
    required int delta,
  }) async {}

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Future<void> _pump(
  WidgetTester tester, {
  required CourseEntity course,
  required _FakeSectionsRepo sectionsRepo,
  required _FakeItemsRepo itemsRepo,
}) async {
  ignoreOverflowErrors();
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(700, 1400);
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  final navigatorKey = GlobalKey<NavigatorState>();
  Localingo.setNavigatorKey(navigatorKey);
  await tester.pumpWidget(
    MaterialApp(
      navigatorKey: navigatorKey,
      locale: const Locale('en'),
      supportedLocales: const [Locale('ar'), Locale('en'), Locale('fr')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: AppTheme.dark,
      home: BlocProvider(
        create: (_) => CourseSectionsCubit(
          courseSectionsRepo: sectionsRepo,
          sectionItemsActionsRepo: itemsRepo,
        ),
        child: Scaffold(
          body: CourseDetailsCourseSectionsViewBody(courseEntity: course),
        ),
      ),
    ),
  );
  await pumpLocalized(tester);
}

/// The add screens build their own [CourseSectionsCubit], separate from the
/// list's, and write through the same app-wide repos.
Future<void> _saveFromAddScreen(
  WidgetTester tester,
  _FakeSectionsRepo sectionsRepo,
  _FakeItemsRepo itemsRepo,
  Future<void> Function(CourseSectionsCubit addScreenCubit) save,
) async {
  final addScreenCubit = CourseSectionsCubit(
    courseSectionsRepo: sectionsRepo,
    sectionItemsActionsRepo: itemsRepo,
  );
  addTearDown(addScreenCubit.close);
  await save(addScreenCubit);
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(preloadL10nAssets);

  group('repos publish what they save', () {
    test('a saved section is published with its course', () async {
      final repo = CourseSectionsRepoImpl(
        datebaseservice: _Database(),
        courseCountersRepo: _Counters(),
      );
      final next = repo.addedSections.first;
      final section = _section('s1', 'Lecture 1');

      final result = await repo.addCourseSection(
        courseId: 'c1',
        section: section,
      );

      expect(result.isRight(), isTrue);
      final change = await next;
      expect(change.courseId, 'c1');
      expect(change.section, same(section));
    });

    test('a section that fails to save is not published', () async {
      final repo = CourseSectionsRepoImpl(
        datebaseservice: _Database(failWrites: true),
        courseCountersRepo: _Counters(),
      );
      final published = <AddedCourseSection>[];
      final subscription = repo.addedSections.listen(published.add);
      addTearDown(subscription.cancel);

      final result = await repo.addCourseSection(
        courseId: 'c1',
        section: _section('s1', 'Lecture 1'),
      );
      await Future<void>.delayed(Duration.zero);

      expect(result.isLeft(), isTrue);
      expect(published, isEmpty);
    });

    test('a saved item is published with its course and section', () async {
      final repo = SectionItemsActionsRepoImpli(
        datebaseservice: _Database(),
        courseCountersRepo: _Counters(),
        isTeacher: () => true,
      );
      final next = repo.addedItems.first;
      final file = _file('f1', 'Notes');

      final result = await repo.addSectionItem(
        sectionItem: file,
        courseId: 'c1',
        sectionId: 's1',
        teacherId: 'teacher-1',
      );

      expect(result.isRight(), isTrue);
      final change = await next;
      expect(change.courseId, 'c1');
      expect(change.sectionId, 's1');
      expect(change.item, same(file));
    });

    test('an item that fails to save is not published', () async {
      final repo = SectionItemsActionsRepoImpli(
        datebaseservice: _Database(failWrites: true),
        courseCountersRepo: _Counters(),
        isTeacher: () => true,
      );
      final published = <AddedSectionItem>[];
      final subscription = repo.addedItems.listen(published.add);
      addTearDown(subscription.cancel);

      final result = await repo.addSectionItem(
        sectionItem: _file('f1', 'Notes'),
        courseId: 'c1',
        sectionId: 's1',
        teacherId: 'teacher-1',
      );
      await Future<void>.delayed(Duration.zero);

      expect(result.isLeft(), isTrue);
      expect(published, isEmpty);
    });
  });

  group('CourseSectionsCubit.watchCourseContent', () {
    test('passes on additions to the watched course only', () async {
      final sectionsRepo = _FakeSectionsRepo([]);
      final itemsRepo = _FakeItemsRepo({});
      final cubit = CourseSectionsCubit(
        courseSectionsRepo: sectionsRepo,
        sectionItemsActionsRepo: itemsRepo,
      )..watchCourseContent(courseId: 'c1');
      final states = <CourseSectionsState>[];
      final subscription = cubit.stream.listen(states.add);

      await sectionsRepo.addCourseSection(
        section: _section('other', 'Other course'),
        courseId: 'c2',
      );
      await sectionsRepo.addCourseSection(
        section: _section('s2', 'Lecture 2'),
        courseId: 'c1',
      );
      await itemsRepo.addSectionItem(
        sectionItem: _file('f1', 'Notes'),
        teacherId: 'teacher-1',
        courseId: 'c1',
        sectionId: 's2',
      );
      await Future<void>.delayed(Duration.zero);

      expect(states, hasLength(2));
      expect((states[0] as CourseSectionAddedLocally).section.id, 's2');
      final itemAdded = states[1] as SectionItemAddedLocally;
      expect(itemAdded.sectionId, 's2');
      expect(itemAdded.item.id, 'f1');

      await subscription.cancel();
      await cubit.close();
    });

    test('stops listening once closed', () async {
      final sectionsRepo = _FakeSectionsRepo([]);
      final itemsRepo = _FakeItemsRepo({});
      final cubit = CourseSectionsCubit(
        courseSectionsRepo: sectionsRepo,
        sectionItemsActionsRepo: itemsRepo,
      )..watchCourseContent(courseId: 'c1');
      expect(sectionsRepo._added.hasListener, isTrue);
      expect(itemsRepo._added.hasListener, isTrue);

      await cubit.close();

      expect(sectionsRepo._added.hasListener, isFalse);
      expect(itemsRepo._added.hasListener, isFalse);
    });
  });

  group('course content screen', () {
    testWidgets(
      'a section added on the add screen shows up without reopening',
      (tester) async {
        final course = _course('c1');
        final sectionsRepo = _FakeSectionsRepo([_section('s1', 'Lecture 1')]);
        final itemsRepo = _FakeItemsRepo({});
        await _pump(
          tester,
          course: course,
          sectionsRepo: sectionsRepo,
          itemsRepo: itemsRepo,
        );
        expect(find.text('Lecture 1'), findsOneWidget);
        expect(find.text('Lecture 2'), findsNothing);

        await _saveFromAddScreen(
          tester,
          sectionsRepo,
          itemsRepo,
          (cubit) => cubit.addCourseSection(
            section: _section('s2', 'Lecture 2'),
            courseId: course.id,
            sectionItem: _file('f1', 'Intro notes'),
            teacherId: 'teacher-1',
          ),
        );

        expect(find.text('Lecture 1'), findsOneWidget);
        expect(find.text('Lecture 2'), findsOneWidget);
        expect(sectionsRepo.fetches, 1);

        // Opening the new section loads the item that was saved with it.
        await tester.tap(find.text('Lecture 2'));
        await tester.pumpAndSettle();
        expect(find.text('Intro notes'), findsOneWidget);
      },
    );

    testWidgets('a section added to another course is not shown', (
      tester,
    ) async {
      final course = _course('c1');
      final sectionsRepo = _FakeSectionsRepo([_section('s1', 'Lecture 1')]);
      final itemsRepo = _FakeItemsRepo({});
      await _pump(
        tester,
        course: course,
        sectionsRepo: sectionsRepo,
        itemsRepo: itemsRepo,
      );

      await _saveFromAddScreen(
        tester,
        sectionsRepo,
        itemsRepo,
        (cubit) => cubit.addCourseSection(
          section: _section('x1', 'Other course lecture'),
          courseId: 'c2',
          sectionItem: _file('f1', 'Notes'),
          teacherId: 'teacher-1',
        ),
      );

      expect(find.text('Other course lecture'), findsNothing);
      expect(find.text('Lecture 1'), findsOneWidget);
    });

    testWidgets('the first section of an empty course shows up', (
      tester,
    ) async {
      final course = _course('c1');
      final sectionsRepo = _FakeSectionsRepo([]);
      final itemsRepo = _FakeItemsRepo({});
      await _pump(
        tester,
        course: course,
        sectionsRepo: sectionsRepo,
        itemsRepo: itemsRepo,
      );
      expect(find.text('Lecture 1'), findsNothing);

      await _saveFromAddScreen(
        tester,
        sectionsRepo,
        itemsRepo,
        (cubit) => cubit.addCourseSection(
          section: _section('s1', 'Lecture 1'),
          courseId: course.id,
          sectionItem: _file('f1', 'Notes'),
          teacherId: 'teacher-1',
        ),
      );

      expect(find.text('Lecture 1'), findsOneWidget);
      expect(sectionsRepo.fetches, 1);
    });

    testWidgets('an item added to an open section shows up without reopening', (
      tester,
    ) async {
      final course = _course('c1');
      final sectionsRepo = _FakeSectionsRepo([_section('s1', 'Lecture 1')]);
      final itemsRepo = _FakeItemsRepo({
        's1': [_file('f1', 'Chapter 1')],
      });
      await _pump(
        tester,
        course: course,
        sectionsRepo: sectionsRepo,
        itemsRepo: itemsRepo,
      );
      await tester.tap(find.text('Lecture 1'));
      await tester.pumpAndSettle();
      expect(find.text('Chapter 1'), findsOneWidget);

      await _saveFromAddScreen(
        tester,
        sectionsRepo,
        itemsRepo,
        (cubit) => cubit.addSectionItem(
          courseId: course.id,
          sectionId: 's1',
          sectionItem: _file('f2', 'Chapter 2'),
          teacherId: 'teacher-1',
        ),
      );

      expect(find.text('Chapter 1'), findsOneWidget);
      expect(find.text('Chapter 2'), findsOneWidget);
      expect(itemsRepo.fetches, 1);
      expect(sectionsRepo.fetches, 1);
    });

    testWidgets('an item added to an empty section replaces the empty note', (
      tester,
    ) async {
      final course = _course('c1');
      final sectionsRepo = _FakeSectionsRepo([_section('s1', 'Lecture 1')]);
      final itemsRepo = _FakeItemsRepo({});
      await _pump(
        tester,
        course: course,
        sectionsRepo: sectionsRepo,
        itemsRepo: itemsRepo,
      );
      await tester.tap(find.text('Lecture 1'));
      await tester.pumpAndSettle();
      expect(find.byType(EmptySectionMessage), findsOneWidget);

      await _saveFromAddScreen(
        tester,
        sectionsRepo,
        itemsRepo,
        (cubit) => cubit.addSectionItem(
          courseId: course.id,
          sectionId: 's1',
          sectionItem: _file('f1', 'Chapter 1'),
          teacherId: 'teacher-1',
        ),
      );

      expect(find.byType(EmptySectionMessage), findsNothing);
      expect(find.text('Chapter 1'), findsOneWidget);
      expect(itemsRepo.fetches, 1);
    });

    testWidgets('an item only goes to the section it was added to', (
      tester,
    ) async {
      final course = _course('c1');
      final sectionsRepo = _FakeSectionsRepo([
        _section('s1', 'Lecture 1'),
        _section('s2', 'Lecture 2'),
      ]);
      final itemsRepo = _FakeItemsRepo({
        's1': [_file('f1', 'Chapter 1')],
        's2': [_file('f2', 'Chapter 2')],
      });
      await _pump(
        tester,
        course: course,
        sectionsRepo: sectionsRepo,
        itemsRepo: itemsRepo,
      );
      await tester.tap(find.text('Lecture 1'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Lecture 2'));
      await tester.pumpAndSettle();

      await _saveFromAddScreen(
        tester,
        sectionsRepo,
        itemsRepo,
        (cubit) => cubit.addSectionItem(
          courseId: course.id,
          sectionId: 's2',
          sectionItem: _file('f3', 'Chapter 3'),
          teacherId: 'teacher-1',
        ),
      );

      expect(find.text('Chapter 3'), findsOneWidget);
      final lecture2Card = find.ancestor(
        of: find.text('Chapter 3'),
        matching: find.byKey(const ValueKey<String>('s2')),
      );
      expect(lecture2Card, findsOneWidget);
    });
  });
}

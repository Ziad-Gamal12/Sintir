import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localingo/localingo.dart';
import 'package:sintir/Core/Managers/Cubits/network_status_cubit/network_status_cubit.dart';
import 'package:sintir/Core/Themes/app_theme.dart';
import 'package:sintir/Core/entities/CourseEntities/ContentCreaterEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStorePaginateResponse.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/models/CourseModel.dart';
import 'package:sintir/Core/repos/CoursesRepo/CoursesRepo_impl.dart';
import 'package:sintir/Core/repos/ReviewModerationRepo/ReviewModerationRepo.dart';
import 'package:sintir/Core/repos/ReviewModerationRepo/ReviewModerationRepoImpl.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/services/EdgeFunctionsService.dart';
import 'package:sintir/Core/services/FireBase/FirebaseAuth_Service.dart';
import 'package:sintir/Core/services/FireBase/Firebase_FirestoreService.dart';
import 'package:sintir/Core/services/NetworkStatus.dart';
import 'package:sintir/Core/services/StorageService.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Core/widgets/NetworkStatusBanner.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/data/models/CourseFedBacksModel.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseFeedbackReplyEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CoursefedbackItemEntity.dart';
import 'package:sintir/Features/Profile/Data/Repos/AccountDeletionRepoImpl.dart';
import 'package:sintir/Features/Profile/Domain/Repos/AccountDeletionRepo.dart';
import 'package:sintir/Features/Profile/Presentation/Manager/delete_account_cubit/delete_account_cubit.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherCourseState.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/course_detail_state_notice.dart';
import 'package:sintir/locale_keys.dart';

class _FakeNetwork implements NetworkStatus {
  _FakeNetwork({this.isOnline = true});

  final StreamController<bool> controller = StreamController<bool>.broadcast();

  @override
  bool isOnline;

  @override
  Stream<bool> get changes => controller.stream;

  void set(bool online) {
    isOnline = online;
    controller.add(online);
  }
}

class _Write {
  _Write(this.kind, this.data, this.requirements);
  final String kind;
  final Map<String, dynamic> data;
  final FireStoreRequirmentsEntity requirements;
}

class _RecordingDatabase implements DataBaseService {
  final List<_Write> writes = [];
  Map<String, dynamic>? existingDoc;
  CustomException? failWith;

  @override
  Future<void> updateData({
    required dynamic data,
    required FireStoreRequirmentsEntity requirements,
    String? field,
  }) async {
    if (failWith != null) throw failWith!;
    writes.add(_Write('update', Map<String, dynamic>.from(data as Map), requirements));
  }

  @override
  Future<void> setData({
    required Map<String, dynamic> data,
    required FireStoreRequirmentsEntity requirements,
  }) async {
    if (failWith != null) throw failWith!;
    writes.add(_Write('set', data, requirements));
  }

  @override
  Future<FireStoreResponse> getData({
    required FireStoreRequirmentsEntity requirements,
    Map<String, dynamic>? query,
  }) async => FireStoreResponse(docData: existingDoc);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _UnusedStorage implements StorageService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeDeletionRepo implements AccountDeletionRepo {
  _FakeDeletionRepo(this.result);

  final Either<Failure, AccountDeletionResult> result;
  int calls = 0;

  @override
  AccountSignInMethod signInMethod() => AccountSignInMethod.password;

  @override
  Future<Either<Failure, AccountDeletionResult>> deleteAccount({
    String? password,
    required bool acknowledgeBalance,
  }) async {
    calls++;
    return result;
  }
}

CoursefeedbackItemEntity _review({CourseFeedbackReplyEntity? reply}) =>
    CoursefeedbackItemEntity(
      userImage: '',
      name: 'Sara',
      uid: 'student-1',
      fedBack: 'Too fast',
      datePosted: DateTime(2026, 10, 1),
      rating: 2,
      teacherReply: reply,
    );

Future<void> _pumpLocalized(WidgetTester tester, Widget child) async {
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
      theme: AppTheme.light,
      home: child,
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  group('connectivity', () {
    test('no network interface means offline without probing', () async {
      var probes = 0;
      final service = ConnectivityService(
        connectivityChanges: const Stream.empty(),
        checkConnectivity: () async => [ConnectivityResult.none],
        probe: () async {
          probes++;
          return true;
        },
      );
      await service.start();
      expect(service.isOnline, isFalse);
      expect(probes, 0);
      await service.dispose();
    });

    test('wifi without internet is offline; it comes back when the probe passes', () async {
      final changes = StreamController<List<ConnectivityResult>>();
      var reachable = false;
      final service = ConnectivityService(
        connectivityChanges: changes.stream,
        checkConnectivity: () async => [ConnectivityResult.wifi],
        probe: () async => reachable,
      );
      final events = <bool>[];
      service.changes.listen(events.add);
      await service.start();
      expect(service.isOnline, isFalse);
      reachable = true;
      changes.add([ConnectivityResult.mobile]);
      await Future<void>.delayed(Duration.zero);
      expect(service.isOnline, isTrue);
      expect(events, [false, true]);
      await changes.close();
      await service.dispose();
    });

    test('a slow probe result does not overwrite a newer one', () async {
      final slow = Completer<bool>();
      var call = 0;
      final changes = StreamController<List<ConnectivityResult>>();
      final service = ConnectivityService(
        connectivityChanges: changes.stream,
        checkConnectivity: () async => [ConnectivityResult.none],
        probe: () => ++call == 1 ? slow.future : Future.value(false),
      );
      await service.start();
      changes.add([ConnectivityResult.wifi]);
      await Future<void>.delayed(Duration.zero);
      changes.add([ConnectivityResult.none]);
      await Future<void>.delayed(Duration.zero);
      slow.complete(true);
      await Future<void>.delayed(Duration.zero);
      expect(service.isOnline, isFalse);
      await changes.close();
      await service.dispose();
    });

    test('the banner state goes offline, then restored, then hides', () async {
      final network = _FakeNetwork();
      final cubit = NetworkStatusCubit(
        network: network,
        restoredDuration: const Duration(milliseconds: 20),
      );
      final states = <NetworkBannerStatus>[];
      final sub = cubit.stream.listen(states.add);
      network.set(false);
      network.set(true);
      await Future<void>.delayed(const Duration(milliseconds: 60));
      expect(states, [
        NetworkBannerStatus.offline,
        NetworkBannerStatus.restored,
        NetworkBannerStatus.online,
      ]);
      await sub.cancel();
      await cubit.close();
    });

    test('an empty read while offline counts as no data', () {
      expect(FirebaseFirestoreservice.isEmptyResponse(FireStoreResponse()), isTrue);
      expect(
        FirebaseFirestoreservice.isEmptyResponse(FireStoreResponse(listData: const [])),
        isTrue,
      );
      expect(
        FirebaseFirestoreservice.isEmptyResponse(FireStoreResponse(docData: const {'a': 1})),
        isFalse,
      );
    });

    test('server functions fail fast offline without sending anything', () async {
      var sent = false;
      final service = EdgeFunctionsService(
        tokenProvider: () async => 'token',
        invoker: (name, body, token) async {
          sent = true;
          return const EdgeFunctionResponse(status: 200, data: {'ok': true});
        },
        network: _FakeNetwork(isOnline: false),
      );
      await expectLater(
        service.invoke('anything', const {}),
        throwsA(isA<EdgeFunctionException>().having((e) => e.code, 'code', 'network_error')),
      );
      expect(sent, isFalse);
    });

    testWidgets('the offline banner shows above the app and keeps the screen', (tester) async {
      final network = _FakeNetwork();
      final cubit = NetworkStatusCubit(
        network: network,
        restoredDuration: const Duration(milliseconds: 50),
      );
      addTearDown(cubit.close);
      await _pumpLocalized(
        tester,
        BlocProvider.value(
          value: cubit,
          child: const NetworkStatusBanner(child: Scaffold(body: Text('screen'))),
        ),
      );
      expect(find.byKey(const ValueKey('network-banner-offline')), findsNothing);
      network.set(false);
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('network-banner-offline')), findsOneWidget);
      expect(find.text(LocaleKeys.offlineBannerMessage), findsOneWidget);
      expect(find.text('screen'), findsOneWidget);
      network.set(true);
      await tester.pump();
      expect(find.byKey(const ValueKey('network-banner-restored')), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 60));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('network-banner-restored')), findsNothing);
      expect(find.text('screen'), findsOneWidget);
    });

    testWidgets('a connection error retries by tap and again when back online', (tester) async {
      final network = _FakeNetwork(isOnline: false);
      final previous = NetworkStatus.current;
      NetworkStatus.current = network;
      addTearDown(() => NetworkStatus.current = previous);
      var retries = 0;
      await _pumpLocalized(
        tester,
        Scaffold(
          body: Builder(
            builder: (_) => CustomErrorWidget(
              errormessage: LocaleKeys.noInternet,
              onRetry: () => retries++,
            ),
          ),
        ),
      );
      expect(find.byIcon(Icons.wifi_off_rounded), findsOneWidget);
      expect(find.text(LocaleKeys.offlineAutoRetryHint), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('error-retry-button')));
      expect(retries, 1);
      network.set(true);
      await tester.pump();
      expect(retries, 2);
    });
  });

  group('account deletion', () {
    test('server error codes become clear messages', () {
      expect(AccountDeletionRepoImpl.failureMessage('requires_recent_login'), LocaleKeys.accountDeleteSignInAgain);
      expect(AccountDeletionRepoImpl.failureMessage('payout_pending'), LocaleKeys.accountDeletePayoutPending);
      expect(AccountDeletionRepoImpl.failureMessage('balance_remaining'), LocaleKeys.accountDeleteBalanceRemaining);
      expect(AccountDeletionRepoImpl.failureMessage('payment_in_progress'), LocaleKeys.accountDeletePaymentInProgress);
      expect(AccountDeletionRepoImpl.failureMessage('staff_account'), LocaleKeys.accountDeleteStaffBlocked);
      expect(AccountDeletionRepoImpl.failureMessage('deletion_incomplete'), LocaleKeys.accountDeleteIncomplete);
      expect(AccountDeletionRepoImpl.failureMessage('network_error'), LocaleKeys.noInternet);
      expect(AccountDeletionRepoImpl.failureMessage('whatever'), LocaleKeys.errorOccurredMessage);
    });

    test('the sign-in method decides how the user confirms', () {
      expect(firebaseAuthService.primaryProviderOf(['google.com', 'password']), 'password');
      expect(firebaseAuthService.primaryProviderOf(['facebook.com']), 'facebook.com');
      expect(firebaseAuthService.primaryProviderOf([]), isNull);
      expect(AccountDeletionRepoImpl.methodFor('google.com'), AccountSignInMethod.google);
      expect(AccountDeletionRepoImpl.methodFor('phone'), AccountSignInMethod.other);
    });

    test('a failed re-sign-in deletes nothing', () async {
      var invoked = false;
      var cleared = false;
      final repo = AccountDeletionRepoImpl(
        edgeFunctions: EdgeFunctionsService(
          tokenProvider: () async => 'token',
          invoker: (name, body, token) async {
            invoked = true;
            return const EdgeFunctionResponse(status: 200, data: {'ok': true});
          },
        ),
        reauthenticate: ({String? password}) async =>
            throw CustomException(message: 'wrong'),
        signInProvider: () => 'password',
        clearLocalSession: () async => cleared = true,
      );
      final result = await repo.deleteAccount(password: 'x', acknowledgeBalance: false);
      expect(result.isLeft(), isTrue);
      expect(invoked, isFalse);
      expect(cleared, isFalse);
    });

    test('a confirmed deletion calls the server once and signs out locally', () async {
      String? called;
      Map<String, dynamic>? sentBody;
      var cleared = false;
      final repo = AccountDeletionRepoImpl(
        edgeFunctions: EdgeFunctionsService(
          tokenProvider: () async => 'token',
          invoker: (name, body, token) async {
            called = name;
            sentBody = body;
            return const EdgeFunctionResponse(
              status: 200,
              data: {'ok': true, 'deleted': true, 'coursesKept': 1, 'coursesDeleted': 2},
            );
          },
        ),
        reauthenticate: ({String? password}) async {},
        signInProvider: () => 'google.com',
        clearLocalSession: () async => cleared = true,
      );
      final result = await repo.deleteAccount(acknowledgeBalance: true);
      expect(called, 'delete-account');
      expect(sentBody, {'acknowledgeBalance': true});
      expect(cleared, isTrue);
      final summary = result.getOrElse(() => const AccountDeletionResult());
      expect(summary.coursesKept, 1);
      expect(summary.coursesDeleted, 2);
    });

    test('the server refusing keeps the user signed in with the reason', () async {
      var cleared = false;
      final repo = AccountDeletionRepoImpl(
        edgeFunctions: EdgeFunctionsService(
          tokenProvider: () async => 'token',
          invoker: (name, body, token) async => const EdgeFunctionResponse(
            status: 409,
            data: {'ok': false, 'error': {'code': 'payout_pending', 'message': 'x'}},
          ),
        ),
        reauthenticate: ({String? password}) async {},
        signInProvider: () => 'password',
        clearLocalSession: () async => cleared = true,
      );
      final result = await repo.deleteAccount(password: 'p', acknowledgeBalance: false);
      result.fold(
        (failure) => expect(failure.message, LocaleKeys.accountDeletePayoutPending),
        (_) => fail('expected a failure'),
      );
      expect(cleared, isFalse);
    });

    test('the cubit ignores a second tap while deleting', () async {
      final repo = _FakeDeletionRepo(right(const AccountDeletionResult()));
      final cubit = DeleteAccountCubit(repo: repo);
      final first = cubit.deleteAccount(acknowledgeBalance: false);
      final second = cubit.deleteAccount(acknowledgeBalance: false);
      await Future.wait([first, second]);
      expect(repo.calls, 1);
      expect(cubit.state, isA<DeleteAccountSuccess>());
      await cubit.close();
    });
  });

  group('decline reason and resubmission', () {
    test('the course reads the reviewer reason and dates', () {
      final model = Coursemodel.fromJson({
        'id': 'c1',
        'posterUrl': '',
        'title': 't',
        'description': 'd',
        'price': 10,
        'language': 'ar',
        'subject': 's',
        'level': 'l',
        'state': 'Declined',
        'studentsCount': 0,
        'postedDate': Timestamp.fromDate(DateTime(2026, 1, 1)),
        'contentcreaterentity': {'id': 't1', 'name': 'T', 'profileImageUrl': '', 'title': ''},
        'declineReason': '  Poster is blurry  ',
        'declinedAt': Timestamp.fromDate(DateTime(2026, 11, 1)),
      });
      final entity = model.toEntity();
      expect(entity.declineReason, 'Poster is blurry');
      expect(entity.declinedAt, DateTime(2026, 11, 1));
      expect(Coursemodel.reasonOrNull('   '), isNull);
    });

    test('resubmitting updates only state and resubmittedAt on both copies', () async {
      final database = _RecordingDatabase();
      final repo = CoursesrepoImpl(databaseservice: database, storageService: _UnusedStorage());
      final course = CourseEntity.empty()
        ..id = 'c1'
        ..state = 'Declined'
        ..contentcreaterentity = Contentcreaterentity(
          name: 'T',
          profileImageUrl: '',
          id: 't1',
          title: '',
        );
      final result = await repo.resubmitCourseForReview(courseEntity: course);
      expect(result.isRight(), isTrue);
      expect(database.writes, hasLength(2));
      for (final write in database.writes) {
        expect(write.kind, 'update');
        expect(write.data.keys.toSet(), {'state', 'resubmittedAt'});
        expect(write.data['state'], 'Pending');
        expect(write.data['resubmittedAt'], isA<FieldValue>());
      }
      expect(database.writes.first.requirements.collection, 'Courses');
      expect(database.writes.last.requirements.subDocId, 'c1');
    });

    testWidgets('a declined course shows the reason and a resubmit button', (tester) async {
      var resubmits = 0;
      await _pumpLocalized(
        tester,
        Scaffold(
          body: CourseDetailStateNotice(
            state: TeacherCourseState.declined,
            declineReason: 'Poster is blurry',
            declinedAt: DateTime(2026, 11, 1),
            onResubmit: () => resubmits++,
          ),
        ),
      );
      expect(find.byKey(const ValueKey('course-decline-reason')), findsOneWidget);
      expect(find.text('Poster is blurry'), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('course-resubmit-button')));
      expect(resubmits, 1);
    });

    testWidgets('a course in review shows no reason or resubmit button', (tester) async {
      await _pumpLocalized(
        tester,
        const Scaffold(
          body: CourseDetailStateNotice(
            state: TeacherCourseState.inReview,
            declineReason: 'old reason',
          ),
        ),
      );
      expect(find.byKey(const ValueKey('course-decline-reason')), findsNothing);
      expect(find.byKey(const ValueKey('course-resubmit-button')), findsNothing);
    });
  });

  group('review replies and reports', () {
    test('a reply is parsed only with text and a date', () {
      final reply = Coursefeedbacksmodel.parseReply({
        'text': ' Thanks! ',
        'authorId': 't1',
        'createdAt': Timestamp.fromDate(DateTime(2026, 11, 1)),
      });
      expect(reply?.text, 'Thanks!');
      expect(Coursefeedbacksmodel.parseReply({'text': '   ', 'createdAt': Timestamp.now()}), isNull);
      expect(Coursefeedbacksmodel.parseReply('x'), isNull);
    });

    test('a first reply writes the whole map, an edit keeps createdAt', () {
      final first = ReviewModerationRepoImpl.replyWrite(text: 'Hi', authorId: 't1', isNew: true);
      expect((first['teacherReply'] as Map).keys.toSet(), {'text', 'authorId', 'createdAt', 'updatedAt'});
      final edit = ReviewModerationRepoImpl.replyWrite(text: 'Hi again', authorId: 't1', isNew: false);
      expect(edit.keys.toSet(), {'teacherReply.text', 'teacherReply.updatedAt'});
    });

    test('empty or overlong replies never reach the database', () async {
      final database = _RecordingDatabase();
      final repo = ReviewModerationRepoImpl(
        databaseservice: database,
        currentUserId: () => 't1',
        currentUserRole: () => 'Teacher',
      );
      final empty = await repo.saveReply(courseId: 'c1', review: _review(), text: '   ');
      final long = await repo.saveReply(
        courseId: 'c1',
        review: _review(),
        text: 'x' * (CourseFeedbackReplyEntity.maxLength + 1),
      );
      expect(empty.isLeft(), isTrue);
      expect(long.isLeft(), isTrue);
      expect(database.writes, isEmpty);
    });

    test('saving a reply targets the review document and returns it', () async {
      final database = _RecordingDatabase();
      final repo = ReviewModerationRepoImpl(
        databaseservice: database,
        currentUserId: () => 't1',
        currentUserRole: () => 'Teacher',
        clock: () => DateTime(2026, 11, 18),
      );
      final created = DateTime(2026, 11, 2);
      final result = await repo.saveReply(
        courseId: 'c1',
        review: _review(reply: CourseFeedbackReplyEntity(text: 'old', authorId: 't1', createdAt: created)),
        text: ' new text ',
      );
      final reply = result.getOrElse(() => throw StateError('failed'));
      expect(reply.text, 'new text');
      expect(reply.createdAt, created);
      expect(database.writes.single.requirements.subDocId, 'student-1');
      expect(database.writes.single.data['teacherReply.text'], 'new text');
    });

    test('a report uses one id per reporter and review and refuses repeats', () async {
      final database = _RecordingDatabase();
      final repo = ReviewModerationRepoImpl(
        databaseservice: database,
        currentUserId: () => 't1',
        currentUserRole: () => 'Teacher',
      );
      final sent = await repo.reportReview(
        courseId: 'c1',
        reviewUid: 'student-1',
        reason: ReviewReportReason.personalInfo,
        details: ' phone number ',
      );
      expect(sent.isRight(), isTrue);
      final write = database.writes.single;
      expect(write.kind, 'set');
      expect(write.requirements.docId, 'c1_student-1_t1');
      expect(write.data['reason'], 'personal_info');
      expect(write.data['details'], 'phone number');
      expect(write.data['status'], 'open');
      expect(write.data['reporterRole'], 'Teacher');

      database.existingDoc = {'status': 'open'};
      final again = await repo.reportReview(
        courseId: 'c1',
        reviewUid: 'student-1',
        reason: ReviewReportReason.spam,
      );
      again.fold(
        (failure) => expect(failure.message, LocaleKeys.reviewReportAlreadySent),
        (_) => fail('expected a failure'),
      );
      final own = await repo.reportReview(
        courseId: 'c1',
        reviewUid: 't1',
        reason: ReviewReportReason.spam,
      );
      expect(own.isLeft(), isTrue);
      expect(database.writes, hasLength(1));
    });

    test('copyWith adds and clears a reply', () {
      final review = _review();
      final replied = review.copyWith(
        teacherReply: CourseFeedbackReplyEntity(text: 'x', authorId: 't1', createdAt: DateTime(2026)),
      );
      expect(replied.teacherReply?.text, 'x');
      expect(replied.copyWith(clearReply: true).teacherReply, isNull);
      expect(replied.uid, review.uid);
    });
  });
}

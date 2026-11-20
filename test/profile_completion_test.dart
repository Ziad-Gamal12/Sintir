import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:localingo/localingo.dart';
import 'package:sintir/Core/Managers/Cubits/course_checkout_cubit/course_checkout_cubit.dart';
import 'package:sintir/Core/Themes/app_theme.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/ContentCreaterEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseRatingStatsEntity.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/helper/ProfileCompleteness.dart';
import 'package:sintir/Core/repos/CourseCheckoutRepo/CourseCheckoutRepo.dart';
import 'package:sintir/Core/repos/CourseCheckoutRepo/CourseCheckoutRequestException.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Auth/Domain/Entities/StudentExtraDataEntity.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/CompleteProfile/Data/Repos/ProfileCompletionRepoImpl.dart';
import 'package:sintir/Features/CompleteProfile/Domain/Entities/CompleteProfilePurpose.dart';
import 'package:sintir/Features/CompleteProfile/Domain/Repos/ProfileCompletionRepo.dart';
import 'package:sintir/Features/CompleteProfile/Presentation/Manager/complete_profile_cubit/complete_profile_cubit.dart';
import 'package:sintir/Features/CompleteProfile/Presentation/Views/Widgets/CompleteProfileViewBody.dart';
import 'package:sintir/Features/Home/presentation/views/HomeView.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/CourseCheckoutEntity.dart';
import 'package:sintir/Features/Subscribtion/Presentation/View/Widgets/SubscribtionViewBody.dart';
import 'package:sintir/locale_keys.dart';

UserEntity _user({
  String role = 'Student',
  String firstName = 'Ziad Gamal',
  String lastName = '',
  String phone = '',
  String level = '',
}) => UserEntity(
  uid: 'u1',
  firstName: firstName,
  lastName: lastName,
  fullName: '$firstName $lastName'.trim(),
  email: 'ziad@example.com',
  address: '',
  phoneNumber: phone,
  deviceId: 'device',
  gender: '',
  profilePicurl: '',
  status: BackendEndpoints.activeStatus,
  role: role == 'Student' ? BackendEndpoints.studentRole : role,
  joinedDate: DateTime(2026, 1, 1),
  studentExtraDataEntity: level.isEmpty
      ? null
      : StudentExtraDataEntity(
          educationLevel: level,
          birthDate: DateTime(2010, 5, 1),
        ),
);

const _validInput = ProfileCompletionInput(
  firstName: ' Ziad ',
  lastName: 'Gamal',
  phoneNumber: '+20 101 234 5678',
  educationLevel: '3rd Grade Secondary',
  gender: 'Male',
);

class _Update {
  _Update(this.data, this.requirements);
  final Map<String, dynamic> data;
  final FireStoreRequirmentsEntity requirements;
}

class _RecordingDatabase implements DataBaseService {
  final List<_Update> updates = [];
  CustomException? failWith;

  @override
  Future<void> updateData({
    required dynamic data,
    required FireStoreRequirmentsEntity requirements,
    String? field,
  }) async {
    if (failWith != null) throw failWith!;
    updates.add(_Update(Map<String, dynamic>.from(data as Map), requirements));
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeProfileRepo implements ProfileCompletionRepo {
  _FakeProfileRepo(this.user);

  final UserEntity user;
  final List<ProfileCompletionInput> saved = [];
  Completer<Either<Failure, UserEntity>>? pending;

  @override
  UserEntity currentUser() => user;

  @override
  Future<Either<Failure, UserEntity>> completeProfile(
    ProfileCompletionInput input,
  ) {
    saved.add(input);
    return pending?.future ?? Future.value(Right(user));
  }
}

class _FakeCheckoutGateway implements CourseCheckoutGateway {
  int createCalls = 0;
  Object? createError;

  @override
  Future<CourseCheckoutQuote> quote({
    required String courseId,
    String? couponCode,
  }) => throw UnimplementedError();

  @override
  Future<CoursePaymentAttempt> createPayment({
    required String courseId,
    required String idempotencyKey,
    String? couponCode,
  }) {
    createCalls++;
    final error = createError;
    if (error != null) {
      createError = null;
      return Future.error(error);
    }
    return Completer<CoursePaymentAttempt>().future;
  }

  @override
  Future<CoursePaymentStatusResult> paymentStatus(
    String paymentAttemptId,
  ) async => const CoursePaymentStatusResult(status: 'pending');

  @override
  Future<bool> isSubscribed(String courseId) async => false;
}

CourseEntity _course() => CourseEntity(
  id: 'c1',
  state: 'published',
  posterUrl: '',
  studentsCount: 2,
  subject: 'Chemistry',
  level: '3rd Grade Secondary',
  title: 'Chemistry',
  description: '',
  price: 200,
  language: 'العربية',
  postedDate: DateTime(2026, 9, 1),
  lessonsCount: 2,
  testsCount: 1,
  feedBacksCount: 0,
  contentcreaterentity: Contentcreaterentity(
    name: 'Teacher',
    profileImageUrl: '',
    id: 't1',
    title: '',
  ),
  ratingStats: const CourseRatingStatsEntity(ratingsSum: 0, ratingsCount: 0),
);

const _delegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

Future<void> _pumpRouter(WidgetTester tester, GoRouter router) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(400, 900);
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(
    MaterialApp.router(
      routerConfig: router,
      locale: const Locale('en'),
      supportedLocales: const [Locale('ar'), Locale('en'), Locale('fr')],
      localizationsDelegates: _delegates,
      theme: AppTheme.light,
    ),
  );
  await tester.pumpAndSettle();
}

Widget _completionScreen(ProfileCompletionRepo repo) => Scaffold(
  body: BlocProvider(
    create: (_) => CompleteProfileCubit(repo: repo),
    child: CompleteProfileViewBody(method: null),
  ),
);

GoRouter _router(
  GlobalKey<NavigatorState> key,
  Widget Function(BuildContext) start, {
  required ProfileCompletionRepo repo,
}) => GoRouter(
  navigatorKey: key,
  routes: [
    GoRoute(path: '/', builder: (context, _) => start(context)),
    GoRoute(
      path: Homeview.routeName,
      builder: (_, __) => const Scaffold(body: Text('home-screen')),
    ),
    GoRoute(path: '/complete', builder: (_, state) => _completionScreen(repo)),
  ],
);

Finder _field(String key) => find.descendant(
  of: find.byKey(ValueKey(key)),
  matching: find.byType(TextFormField),
);

void main() {
  group('profile completeness rules', () {
    test('Egyptian mobile numbers are normalized and validated', () {
      expect(
        ProfileCompleteness.normalizePhone('+20 101 234 5678'),
        '01012345678',
      );
      expect(
        ProfileCompleteness.normalizePhone('00201112345678'),
        '01112345678',
      );
      expect(ProfileCompleteness.normalizePhone('201512345678'), '01512345678');
      expect(ProfileCompleteness.isValidPhone('01012345678'), isTrue);
      expect(ProfileCompleteness.isValidPhone('01212345678'), isTrue);
      expect(ProfileCompleteness.isValidPhone('0101234567'), isFalse);
      expect(ProfileCompleteness.isValidPhone('01312345678'), isFalse);
      expect(ProfileCompleteness.isValidPhone('NA'), isFalse);
      expect(ProfileCompleteness.isValidPhone(''), isFalse);
    });

    test(
      'a Google or Facebook student is missing last name, phone and level',
      () {
        expect(ProfileCompleteness.missingForAccount(_user()), [
          ProfileField.lastName,
          ProfileField.phone,
          ProfileField.educationLevel,
        ]);
        expect(ProfileCompleteness.needsCompletion(_user()), isTrue);
      },
    );

    test('a complete student and any teacher need nothing', () {
      final complete = _user(
        firstName: 'Ziad',
        lastName: 'Gamal',
        phone: '01012345678',
        level: '3rd Grade Secondary',
      );
      expect(ProfileCompleteness.missingForAccount(complete), isEmpty);
      expect(ProfileCompleteness.missingForPayment(complete), isEmpty);
      expect(
        ProfileCompleteness.missingForAccount(_user(role: 'Teacher')),
        isEmpty,
      );
      expect(
        ProfileCompleteness.missingForPayment(_user(role: 'Teacher')),
        isEmpty,
      );
    });

    test('payment needs only a name and a valid phone', () {
      expect(ProfileCompleteness.missingForPayment(_user()), [
        ProfileField.phone,
      ]);
      expect(ProfileCompleteness.missingForPayment(_user(phone: '0101')), [
        ProfileField.phone,
      ]);
      expect(
        ProfileCompleteness.missingForPayment(_user(phone: '01012345678')),
        isEmpty,
      );
    });

    test('a display name is split into first and last name', () {
      final name = ProfileCompleteness.splitName(
        _user(firstName: 'Ziad Gamal Ali'),
      );
      expect(name.first, 'Ziad');
      expect(name.last, 'Gamal Ali');
      final kept = ProfileCompleteness.splitName(
        _user(firstName: 'Ziad', lastName: 'Gamal'),
      );
      expect(kept.first, 'Ziad');
      expect(kept.last, 'Gamal');
    });
  });

  group('profile completion repo', () {
    test('saves the fields to the user document and the local copy', () async {
      final db = _RecordingDatabase();
      Map<String, dynamic>? local;
      final repo = ProfileCompletionRepoImpl(
        databaseService: db,
        readCurrentUser: () => _user(level: '1st Grade Secondary'),
        saveLocalUser: (json) async => local = json,
      );

      final result = await repo.completeProfile(_validInput);

      expect(result.isRight(), isTrue);
      expect(db.updates, hasLength(1));
      final update = db.updates.single;
      expect(
        update.requirements.collection,
        BackendEndpoints.usersCollectionName,
      );
      expect(update.requirements.docId, 'u1');
      expect(update.data['firstName'], 'Ziad');
      expect(update.data['lastName'], 'Gamal');
      expect(update.data['fullName'], 'Ziad Gamal');
      expect(update.data['phoneNumber'], '01012345678');
      expect(update.data['gender'], 'Male');
      expect(update.data['studentExtraData'], {
        'educationLevel': '3rd Grade Secondary',
        'birthDate': DateTime(2010, 5, 1),
      });
      expect(update.data.keys, isNot(contains('role')));
      expect(update.data.keys, isNot(contains('status')));
      expect(local?['phoneNumber'], '01012345678');
      expect(
        local?['studentExtraData']['educationLevel'],
        '3rd Grade Secondary',
      );
      final user = result.getOrElse(() => _user());
      expect(ProfileCompleteness.needsCompletion(user), isFalse);
    });

    test('an invalid phone or missing level writes nothing', () async {
      final db = _RecordingDatabase();
      final repo = ProfileCompletionRepoImpl(
        databaseService: db,
        readCurrentUser: _user,
        saveLocalUser: (_) async {},
      );

      final badPhone = await repo.completeProfile(
        const ProfileCompletionInput(
          firstName: 'Ziad',
          lastName: 'Gamal',
          phoneNumber: '0123',
          educationLevel: '3rd Grade Secondary',
          gender: '',
        ),
      );
      final noLevel = await repo.completeProfile(
        const ProfileCompletionInput(
          firstName: 'Ziad',
          lastName: 'Gamal',
          phoneNumber: '01012345678',
          educationLevel: '',
          gender: '',
        ),
      );

      expect(
        badPhone.fold((f) => f.message, (_) => ''),
        LocaleKeys.phoneInvalid,
      );
      expect(
        noLevel.fold((f) => f.message, (_) => ''),
        LocaleKeys.completeProfileLevelRequired,
      );
      expect(db.updates, isEmpty);
    });

    test('a failed write keeps the local copy unchanged', () async {
      final db = _RecordingDatabase()
        ..failWith = CustomException(message: 'offline');
      var localWrites = 0;
      final repo = ProfileCompletionRepoImpl(
        databaseService: db,
        readCurrentUser: _user,
        saveLocalUser: (_) async => localWrites++,
      );

      final result = await repo.completeProfile(_validInput);

      expect(result.fold((f) => f.message, (_) => ''), 'offline');
      expect(localWrites, 0);
    });

    test('an empty gender leaves the stored gender alone', () {
      final fields = ProfileCompletionRepoImpl.updateFields(
        _user(),
        const ProfileCompletionInput(
          firstName: 'Ziad',
          lastName: 'Gamal',
          phoneNumber: '01012345678',
          educationLevel: '3rd Grade Secondary',
          gender: '',
        ),
      );
      expect(fields.containsKey('gender'), isFalse);
    });
  });

  group('complete profile cubit', () {
    test('a second tap while saving is ignored', () async {
      final repo = _FakeProfileRepo(_user())
        ..pending = Completer<Either<Failure, UserEntity>>();
      final cubit = CompleteProfileCubit(repo: repo);

      final first = cubit.save(_validInput);
      await cubit.save(_validInput);
      repo.pending!.complete(Right(_user()));
      await first;

      expect(repo.saved, hasLength(1));
      expect(cubit.state, isA<CompleteProfileSaved>());
      await cubit.close();
    });

    test('a failure shows its message and allows another try', () async {
      final repo = _FakeProfileRepo(_user())
        ..pending = Completer<Either<Failure, UserEntity>>();
      final cubit = CompleteProfileCubit(repo: repo);

      final first = cubit.save(_validInput);
      repo.pending!.complete(Left(ServerFailure(message: 'offline')));
      await first;
      expect((cubit.state as CompleteProfileFailure).message, 'offline');

      repo.pending = null;
      await cubit.save(_validInput);
      expect(repo.saved, hasLength(2));
      await cubit.close();
    });
  });

  group('complete profile screen', () {
    testWidgets('after sign-in it prefills the name, validates and goes home', (
      tester,
    ) async {
      final key = GlobalKey<NavigatorState>();
      Localingo.setNavigatorKey(key);
      final repo = _FakeProfileRepo(_user());
      await _pumpRouter(
        tester,
        _router(key, (_) => _completionScreen(repo), repo: repo),
      );

      expect(
        tester
            .widget<TextFormField>(_field('complete-profile-first-name'))
            .controller
            ?.text,
        'Ziad',
      );
      expect(
        tester
            .widget<TextFormField>(_field('complete-profile-last-name'))
            .controller
            ?.text,
        'Gamal',
      );
      expect(
        find.byKey(const ValueKey('complete-profile-skip')),
        findsOneWidget,
      );

      await tester.enterText(_field('complete-profile-phone'), '0101');
      await tester.tap(find.byKey(const ValueKey('complete-profile-save')));
      await tester.pumpAndSettle();
      expect(find.text(LocaleKeys.phoneInvalid), findsOneWidget);
      expect(
        find.text(LocaleKeys.completeProfileLevelRequired),
        findsOneWidget,
      );
      expect(repo.saved, isEmpty);

      await tester.enterText(_field('complete-profile-phone'), '01012345678');
      await tester.tap(find.byKey(const ValueKey('complete-profile-level')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('3rd Grade Secondary').last);
      await tester.pumpAndSettle();
      await tester.tap(
        find.byKey(const ValueKey('complete-profile-gender-female')),
      );
      await tester.pump();
      await tester.tap(find.byKey(const ValueKey('complete-profile-save')));
      await tester.pumpAndSettle();

      expect(repo.saved, hasLength(1));
      expect(repo.saved.single.phoneNumber, '01012345678');
      expect(repo.saved.single.educationLevel, '3rd Grade Secondary');
      expect(repo.saved.single.gender, 'Female');
      expect(find.text('home-screen'), findsOneWidget);
    });

    testWidgets('later skips to home without saving', (tester) async {
      final key = GlobalKey<NavigatorState>();
      Localingo.setNavigatorKey(key);
      final repo = _FakeProfileRepo(_user());
      await _pumpRouter(
        tester,
        _router(key, (_) => _completionScreen(repo), repo: repo),
      );

      await tester.tap(find.byKey(const ValueKey('complete-profile-skip')));
      await tester.pumpAndSettle();

      expect(repo.saved, isEmpty);
      expect(find.text('home-screen'), findsOneWidget);
    });

    testWidgets('for payment it has no skip and returns true after saving', (
      tester,
    ) async {
      final key = GlobalKey<NavigatorState>();
      Localingo.setNavigatorKey(key);
      final repo = _FakeProfileRepo(
        _user(
          firstName: 'Ziad',
          lastName: 'Gamal',
          level: '3rd Grade Secondary',
        ),
      );
      bool? result;
      await _pumpRouter(
        tester,
        _router(
          key,
          (context) => Scaffold(
            body: TextButton(
              onPressed: () async =>
                  result = await context.push<bool>('/complete'),
              child: const Text('pay'),
            ),
          ),
          repo: repo,
        ),
      );

      await tester.tap(find.text('pay'));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('complete-profile-skip')), findsNothing);
      expect(
        find.text(LocaleKeys.completeProfilePaymentSubtitle),
        findsOneWidget,
      );

      await tester.enterText(_field('complete-profile-phone'), '01112345678');
      await tester.tap(find.byKey(const ValueKey('complete-profile-save')));
      await tester.pumpAndSettle();

      expect(repo.saved.single.phoneNumber, '01112345678');
      expect(result, isTrue);
      expect(find.text('pay'), findsOneWidget);
    });
  });

  group('payment needs a phone first', () {
    Future<_FakeCheckoutGateway> pumpCheckout(
      WidgetTester tester, {
      required UserEntity user,
      required List<bool> answers,
      List<int>? openings,
    }) async {
      final gateway = _FakeCheckoutGateway();
      final key = GlobalKey<NavigatorState>();
      Localingo.setNavigatorKey(key);
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(390, 844);
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      var opened = 0;
      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: key,
          locale: const Locale('en'),
          supportedLocales: const [Locale('ar'), Locale('en'), Locale('fr')],
          localizationsDelegates: _delegates,
          theme: AppTheme.light,
          home: Scaffold(
            body: BlocProvider(
              create: (_) => CourseCheckoutCubit(gateway),
              child: SubscribtionViewBody(
                requirmentsEntity:
                    DisplayCourseBottomsheetNavigationRequirmentsEntity(
                      course: _course(),
                      isSubscribed: false,
                      hasSubscriptionCheckResult: false,
                    ),
                readCurrentUser: () => user,
                openProfileCompletion: (_) async {
                  openings?.add(++opened);
                  return answers.isEmpty ? false : answers.removeAt(0);
                },
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      return gateway;
    }

    Finder subscribe() =>
        find.byKey(const ValueKey('checkout-subscribe-button'));

    testWidgets(
      'without a phone the form opens first and payment waits for it',
      (tester) async {
        final openings = <int>[];
        final gateway = await pumpCheckout(
          tester,
          user: _user(),
          answers: [true],
          openings: openings,
        );

        await tester.tap(subscribe());
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 50));

        expect(openings, [1]);
        expect(gateway.createCalls, 1);
      },
    );

    testWidgets('leaving the form without saving starts no payment', (
      tester,
    ) async {
      final gateway = await pumpCheckout(
        tester,
        user: _user(),
        answers: [false],
      );

      await tester.tap(subscribe());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));

      expect(gateway.createCalls, 0);
    });

    testWidgets('a student with a valid phone pays directly', (tester) async {
      final openings = <int>[];
      final gateway = await pumpCheckout(
        tester,
        user: _user(phone: '01012345678'),
        answers: [],
        openings: openings,
      );

      await tester.tap(subscribe());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));

      expect(openings, isEmpty);
      expect(gateway.createCalls, 1);
    });

    testWidgets(
      'the server asking for a phone opens the form and retries once',
      (tester) async {
        final openings = <int>[];
        final gateway = await pumpCheckout(
          tester,
          user: _user(phone: '01012345678'),
          answers: [true],
          openings: openings,
        );
        gateway.createError = const CourseCheckoutRequestException(
          'billing_phone_missing',
          'Add a valid phone number to your account before checkout.',
          409,
        );

        await tester.tap(subscribe());
        for (var i = 0; i < 5; i++) {
          await tester.pump(const Duration(milliseconds: 50));
        }

        expect(openings, [1]);
        expect(gateway.createCalls, 2);
      },
    );
  });
}

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSubscribtionsCubit/CourseSubscribtionsCubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/CourseCheckoutRepo.dart';
import 'package:sintir/Core/repos/CourseSubscibtionsRepo/CourseSubscibtionsRepo_impli.dart';
import 'package:sintir/Core/repos/PaymobRepo.dart/PaymobRepo.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseIntroduction_Widgets/CourseIntroductionSuccessViewSubscribeButtonBuilder.dart';
import 'package:sintir/Features/Subscribtion/Presentation/View/SubscribtionView.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/PayMobResponse.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/locale_keys.dart';
import 'package:provider/provider.dart';

class _UnusedDatabaseService implements DataBaseService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeCheckoutGateway implements CourseCheckoutGateway {
  _FakeCheckoutGateway();

  bool result = false;
  Object? error;
  String? requestedCourseId;

  @override
  Future<bool> isSubscribed(String courseId) async {
    requestedCourseId = courseId;
    if (error != null) throw error!;
    return result;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _UnusedPaymobRepo implements PaymobRepo {
  @override
  Future<Either<Failure, PayMobResponse>> payWithWallet({
    required UserEntity user,
    required CourseEntity course,
    required double amount,
  }) async =>
      left(ServerFailure(message: 'unused'));
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late _FakeCheckoutGateway gateway;
  late CourseSubscriptionsRepoImpl repo;

  setUp(() {
    gateway = _FakeCheckoutGateway();
    repo = CourseSubscriptionsRepoImpl(
      databaseService: _UnusedDatabaseService(),
      checkoutGateway: gateway,
    );
  });

  test('subscription check calls the injected gateway with the exact ID',
      () async {
    const arabicId = '٤٥٢٧٣٥٤٦';
    gateway.result = true;
    final result = await repo.checkIfSubscribed(courseID: arabicId);

    result.fold(
        (failure) => fail(failure.message), (value) => expect(value, isTrue));
    expect(gateway.requestedCourseId, arabicId);
  });

  test('false is a successful unsubscribed result', () async {
    gateway.result = false;

    final result = await repo.checkIfSubscribed(courseID: '45273546');

    result.fold(
        (failure) => fail(failure.message), (value) => expect(value, isFalse));
  });

  test('gateway errors remain failures and never become false', () async {
    gateway.error = StateError('temporary network error');

    final result = await repo.checkIfSubscribed(courseID: 'course-id');

    expect(result.isLeft(), isTrue);
  });

  test('Cubit emits failure after subscription check error', () async {
    gateway.error = StateError('temporary network error');
    final cubit = CourseSubscribtionsCubit(
      subscribtionRepo: repo,
      course: CourseEntity(
        id: 'course-id',
        state: 'Published',
        studentsCount: 0,
        subject: '',
        level: '',
        title: '',
        description: '',
        price: 100,
        language: '',
        postedDate: DateTime.utc(2026),
      ),
      paymobRepo: _UnusedPaymobRepo(),
    );

    await cubit.checkIfSubscribed();

    expect(cubit.state, isA<CheckIfSubscribedFailure>());
    await cubit.close();
  });

  testWidgets(
      'course introduction refreshes enrollment after checkout returns success',
      (tester) async {
    gateway.result = false;
    final course = CourseEntity(
      id: 'course-id',
      state: 'Published',
      studentsCount: 0,
      subject: '',
      level: '',
      title: 'Physics',
      description: '',
      price: 100,
      language: '',
      postedDate: DateTime.utc(2026),
    );
    final requirements = DisplayCourseBottomsheetNavigationRequirmentsEntity(
      course: course,
      isSubscribed: false,
    );
    final cubit = CourseSubscribtionsCubit(
      subscribtionRepo: repo,
      course: course,
      paymobRepo: _UnusedPaymobRepo(),
    );
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (_, __) => const Scaffold(
            body: CourseIntroductionSuccessViewSubscribeButtonBuilder(
              isSubscribed: false,
            ),
          ),
        ),
        GoRoute(
          path: SubscribtionView.routeName,
          builder: (context, _) => Scaffold(
            body: TextButton(
              key: const Key('complete_checkout_for_test'),
              onPressed: () {
                gateway.result = true;
                context.pop(true);
              },
              child: const Text('Complete checkout'),
            ),
          ),
        ),
      ],
    );
    addTearDown(router.dispose);
    addTearDown(cubit.close);

    await tester.pumpWidget(
      Provider.value(
        value: requirements,
        child: BlocProvider.value(
          value: cubit,
          child: MaterialApp.router(routerConfig: router),
        ),
      ),
    );
    expect(
        tester
            .widget<Visibility>(
                find.byKey(const Key('course_subscription_action')))
            .visible,
        isTrue);

    await tester.tap(find.text(LocaleKeys.subscribeNow));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('complete_checkout_for_test')));
    await tester.pumpAndSettle();

    expect(gateway.requestedCourseId, course.id);
    expect(requirements.isSubscribed, isTrue);
    expect(
        tester
            .widget<Visibility>(
                find.byKey(const Key('course_subscription_action')))
            .visible,
        isFalse);
  });
}

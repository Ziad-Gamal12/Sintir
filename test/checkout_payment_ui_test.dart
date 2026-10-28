import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Core/Managers/Cubits/course_checkout_cubit/course_checkout_cubit.dart';
import 'package:sintir/Core/repos/CourseCheckoutRepo.dart';
import 'package:sintir/Core/widgets/WebViewer/WebViewBody.dart';
import 'package:sintir/Core/widgets/WebViewer/WebviewbodyPaymentSuccessWidget.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/CourseCheckoutEntity.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/PayMobResponse.dart';
import 'package:sintir/Features/Subscribtion/Presentation/View/Widgets/ExistingCheckoutDialog.dart';
import 'package:sintir/locale_keys.dart';

const _quote = CourseCheckoutQuote(
  originalAmountCents: 20000,
  discountAmountCents: 3000,
  amountCents: 17000,
  currency: 'EGP',
  couponCode: 'SAVE',
  discountPercentage: 15,
);

CoursePaymentAttempt _attempt(
        {String checkoutUrl = 'https://checkout.example',
        bool canResume = true,
        String? status}) =>
    CoursePaymentAttempt(
      id: 'attempt-1',
      checkoutUrl: checkoutUrl,
      status:
          status ?? (checkoutUrl.isEmpty ? 'verification_required' : 'pending'),
      quote: _quote,
      requiresConfirmation: true,
      canResume: canResume,
    );

Future<Future<ExistingCheckoutAction?>?> _showExistingCheckoutDialog(
  WidgetTester tester, {
  required CoursePaymentAttempt attempt,
  required String courseTitle,
  bool requestDiffers = false,
  TextDirection? direction,
  TextScaler? textScaler,
}) async {
  Future<ExistingCheckoutAction?>? result;
  await tester.pumpWidget(
    MaterialApp(
      home: MediaQuery(
        data: MediaQueryData(
          size: tester.view.physicalSize / tester.view.devicePixelRatio,
          textScaler: textScaler ?? TextScaler.noScaling,
        ),
        child: Directionality(
          textDirection: direction ?? TextDirection.ltr,
          child: Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: TextButton(
                  onPressed: () {
                    result = showDialog<ExistingCheckoutAction>(
                      context: context,
                      builder: (_) => ExistingCheckoutDialog(
                        courseTitle: courseTitle,
                        attempt: attempt,
                        requestDiffers: requestDiffers,
                      ),
                    );
                  },
                  child: const Text('Open checkout dialog'),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('Open checkout dialog'));
  await tester.pumpAndSettle();
  return result;
}

class _StatusGateway implements CourseCheckoutGateway {
  _StatusGateway(this.results);

  final List<CoursePaymentStatusResult> results;
  int statusCalls = 0;

  @override
  Future<CoursePaymentStatusResult> paymentStatus(
      String paymentAttemptId) async {
    final index = statusCalls++;
    return results[index.clamp(0, results.length - 1).toInt()];
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
      'resumable checkout dialog shows saved details and primary resume',
      (tester) async {
    final result = await _showExistingCheckoutDialog(
      tester,
      attempt: _attempt(),
      courseTitle: 'Algebra and Problem Solving',
    );

    expect(find.text('Algebra and Problem Solving'), findsOneWidget);
    expect(find.text('SAVE'), findsOneWidget);
    expect(find.textContaining('170'), findsOneWidget);
    expect(find.byKey(const Key('checkout_resume_payment')), findsOneWidget);
    expect(find.byKey(const Key('checkout_check_status')), findsOneWidget);
    final checkStatusButton = find.byKey(const Key('checkout_check_status'));
    final checkStatusLabel = find.descendant(
      of: checkStatusButton,
      matching: find.text(LocaleKeys.checkPaymentStatus),
    );
    expect(
      tester.widget<Text>(checkStatusLabel).style?.color,
      Theme.of(tester.element(checkStatusButton)).colorScheme.primary,
      reason: 'Outlined status action must remain readable in the light theme.',
    );

    await tester
        .ensureVisible(find.byKey(const Key('checkout_resume_payment')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('checkout_resume_payment')));
    await tester.pumpAndSettle();
    expect(await result, ExistingCheckoutAction.resumePayment);
  });

  testWidgets('non-resumable dialog hides resume and offers check status/later',
      (tester) async {
    final result = await _showExistingCheckoutDialog(
      tester,
      attempt: _attempt(checkoutUrl: ''),
      courseTitle: 'Physics',
      requestDiffers: true,
    );

    expect(find.byKey(const Key('checkout_resume_payment')), findsNothing);
    expect(find.byKey(const Key('checkout_check_status')), findsOneWidget);
    expect(find.byKey(const Key('checkout_check_later')), findsOneWidget);
    await tester.ensureVisible(find.byKey(const Key('checkout_check_status')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('checkout_check_status')));
    await tester.pumpAndSettle();
    expect(await result, ExistingCheckoutAction.checkStatus);
  });

  testWidgets('checkout URL alone does not authorize resume', (tester) async {
    await _showExistingCheckoutDialog(
      tester,
      attempt: _attempt(canResume: false),
      courseTitle: 'Physics',
    );

    expect(find.byKey(const Key('checkout_resume_payment')), findsNothing);
    expect(find.byKey(const Key('checkout_check_status')), findsOneWidget);
  });

  testWidgets('verification status is presented as verification, not pending',
      (tester) async {
    await _showExistingCheckoutDialog(
      tester,
      attempt: _attempt(status: 'verification_required', canResume: false),
      courseTitle: 'Physics',
    );

    expect(find.text(LocaleKeys.paymentVerificationInProgress), findsOneWidget);
    expect(find.text(LocaleKeys.paymentPending), findsNothing);
    expect(find.text(LocaleKeys.paymentVerifying), findsOneWidget);
  });

  testWidgets('dialog shows a terminal failure only for failed server status',
      (tester) async {
    await _showExistingCheckoutDialog(
      tester,
      attempt: _attempt(status: 'failed', canResume: false),
      courseTitle: 'Physics',
    );

    expect(find.text(LocaleKeys.paymentNotCompleted), findsNWidgets(2));
    expect(find.byKey(const Key('checkout_resume_payment')), findsNothing);
  });

  testWidgets('dialog scrolls with long Arabic content and enlarged text',
      (tester) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final longTitle = List.filled(8, 'عنوان دورة تعليمية طويل').join(' ');

    await _showExistingCheckoutDialog(
      tester,
      attempt: _attempt(),
      courseTitle: longTitle,
      requestDiffers: true,
      direction: TextDirection.rtl,
      textScaler: TextScaler.linear(1.8),
    );

    expect(tester.takeException(), isNull);
    expect(find.text(longTitle), findsOneWidget);
    await tester.ensureVisible(find.byKey(const Key('checkout_check_later')));
    expect(tester.takeException(), isNull);
  });

  testWidgets(
      'success UI appears only after backend reports success and returns true',
      (tester) async {
    final gateway = _StatusGateway([
      const CoursePaymentStatusResult(
        status: 'pending',
        canRetry: true,
        canResume: false,
      ),
      const CoursePaymentStatusResult(
        status: 'succeeded',
        canRetry: false,
      ),
    ]);
    final cubit = CourseCheckoutCubit(gateway);
    final routeResult = Completer<bool?>();

    await tester.pumpWidget(
      BlocProvider.value(
        value: cubit,
        child: MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push<bool>(
                          MaterialPageRoute(
                            builder: (_) => Scaffold(
                              body: Webviewbody(
                                response: PayMobResponse(
                                  url: '',
                                  paymentAttemptId: 'attempt-1',
                                  status: 'verification_required',
                                ),
                                courseTitle: 'Algebra and Problem Solving',
                                quote: _quote,
                              ),
                            ),
                          ),
                        )
                        .then(routeResult.complete);
                  },
                  child: const Text('Open verification'),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open verification'));
    await tester.pumpAndSettle();
    expect(gateway.statusCalls, 1);
    expect(find.byType(WebviewbodyPaymentSuccessWidget), findsNothing);

    await tester.tap(find.byKey(const Key('verification_check_status')));
    await tester.pumpAndSettle();
    expect(gateway.statusCalls, 2);
    expect(find.byType(WebviewbodyPaymentSuccessWidget), findsOneWidget);
    expect(find.text('Algebra and Problem Solving'), findsOneWidget);
    expect(find.textContaining('EGP'), findsNWidgets(3));

    await tester.pump(const Duration(seconds: 10));
    expect(gateway.statusCalls, 2,
        reason: 'A confirmed result must stop further verification requests.');
    await tester
        .ensureVisible(find.byKey(const Key('success_return_to_course')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('success_return_to_course')));
    await tester.pumpAndSettle();
    expect(await routeResult.future, isTrue);
    await cubit.close();
  });

  testWidgets('success screen scrolls in dark RTL with enlarged text',
      (tester) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    var continued = false;

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.dark(useMaterial3: true),
        home: Scaffold(
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: MediaQuery(
              data: const MediaQueryData(
                size: Size(320, 640),
                textScaler: TextScaler.linear(1.8),
              ),
              child: WebviewbodyPaymentSuccessWidget(
                courseTitle: List.filled(8, 'دورة تعليمية طويلة').join(' '),
                quote: _quote,
                onContinue: () => continued = true,
              ),
            ),
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
    await tester
        .ensureVisible(find.byKey(const Key('success_return_to_course')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('success_return_to_course')));
    expect(continued, isTrue);
    expect(tester.takeException(), isNull);
  });

  testWidgets('success screen keeps quote details when course title is absent',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: Scaffold(
            body: WebviewbodyPaymentSuccessWidget(
              quote: _quote,
              onContinue: () {},
            ),
          ),
        ),
      ),
    );

    expect(find.text(LocaleKeys.paymentConfirmedAmount), findsOneWidget);
    expect(find.text('SAVE'), findsOneWidget);
    expect(find.textContaining('EGP'), findsNWidgets(3));
    expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('system back from confirmed success returns the success result',
      (tester) async {
    final cubit = CourseCheckoutCubit(_StatusGateway([]));
    final routeResult = Completer<bool?>();

    await tester.pumpWidget(
      BlocProvider.value(
        value: cubit,
        child: MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push<bool>(
                        MaterialPageRoute(
                          builder: (_) => const Scaffold(
                            body: Webviewbody(
                              response: PayMobResponse(
                                url: '',
                                paymentAttemptId: 'attempt-1',
                                status: 'succeeded',
                              ),
                              courseTitle: 'Physics',
                            ),
                          ),
                        ),
                      )
                      .then(routeResult.complete);
                },
                child: const Text('Open success'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open success'));
    await tester.pumpAndSettle();
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(await routeResult.future, isTrue);
    await cubit.close();
  });
}

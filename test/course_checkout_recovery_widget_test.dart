import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Core/Managers/Cubits/course_checkout_cubit/course_checkout_cubit.dart';
import 'package:sintir/Core/repos/CourseCheckoutRepo.dart';
import 'package:sintir/Core/widgets/WebViewer/WebViewBody.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/CourseCheckoutEntity.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/PayMobResponse.dart';

class _StatusOnlyGateway implements CourseCheckoutGateway {
  int statusCalls = 0;
  final List<String> requestedAttemptIds = [];
  Completer<CoursePaymentStatusResult>? statusCompleter;

  @override
  Future<CoursePaymentStatusResult> paymentStatus(String paymentAttemptId) {
    statusCalls++;
    requestedAttemptIds.add(paymentAttemptId);
    return statusCompleter?.future ?? Future.value(_pendingStatus);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

const _pendingStatus = CoursePaymentStatusResult(
  status: 'pending',
  verificationState: 'cooldown',
  retryAfterSeconds: 20,
  canRetry: true,
  checkoutUrl: 'https://checkout.example/original',
  canResume: true,
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
      'pending status leaves a stable screen and exposes retry after cooldown without polling forever',
      (tester) async {
    final gateway = _StatusOnlyGateway()
      ..statusCompleter = Completer<CoursePaymentStatusResult>();
    final cubit = CourseCheckoutCubit(gateway);
    var currentTime = DateTime(2026, 10, 27);

    await tester.pumpWidget(
      BlocProvider.value(
        value: cubit,
        child: MaterialApp(
          home: Scaffold(
            body: Webviewbody(
              now: () => currentTime,
              response: PayMobResponse(
                url: '',
                paymentAttemptId: 'original-attempt',
                status: 'verification_required',
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(gateway.statusCalls, 1);
    expect(gateway.requestedAttemptIds, ['original-attempt']);
    expect(find.byType(CircularProgressIndicator), findsWidgets);

    gateway.statusCompleter!.complete(_pendingStatus);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(FilledButton), findsOneWidget,
        reason: 'A provider-confirmed payable attempt can be resumed.');

    currentTime = currentTime.add(const Duration(seconds: 20));
    await tester.pump(const Duration(seconds: 20));
    expect(gateway.statusCalls, 1,
        reason:
            'Cooldown expiry must enable a manual check, not restart polling.');
    final checkButton =
        tester.widget<TextButton>(find.byType(TextButton).first);
    expect(checkButton.onPressed, isNotNull);

    await tester.tap(find.byType(TextButton).first);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    expect(gateway.statusCalls, 2);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 30));
    expect(gateway.statusCalls, 2,
        reason:
            'Disposed verification screens must not issue delayed requests.');
    await cubit.close();
  });
}

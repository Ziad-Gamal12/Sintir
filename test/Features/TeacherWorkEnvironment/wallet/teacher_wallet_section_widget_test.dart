import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Core/Themes/app_theme.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/teacher_wallet_card.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkEnvironmentWalletSection.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/states/teacher_wallet_error_card.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/states/teacher_wallet_retry_button.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/states/teacher_wallet_skeleton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/states/teacher_wallet_stale_notice.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/card/teacher_wallet_withdraw_button.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/card/teacher_wallet_withdraw_unavailable_notice.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/teacher_wallet_cubit/teacher_wallet_cubit.dart';
import 'package:sintir/locale_keys.dart';

import 'wallet_test_fakes.dart';

void main() {
  late FakeTeacherLiveWalletRepo repo;
  late TeacherWalletCubit cubit;

  Future<void> pumpSection(
    WidgetTester tester, {
    bool disableAnimations = false,
  }) async {
    // Subscribe inside the test's fake-async zone so stream events are
    // delivered by tester.pump().
    repo = FakeTeacherLiveWalletRepo();
    cubit = TeacherWalletCubit(walletRepo: repo, teacherId: teacherId)
      ..watchWallet();
    addTearDown(cubit.close);

    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(390, 844);
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(disableAnimations: disableAnimations),
          child: child!,
        ),
        home: Scaffold(
          body: BlocProvider.value(
            value: cubit,
            child: const SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: TeacherWorkEnvironmentWalletSection(),
            ),
          ),
        ),
      ),
    );
  }

  Finder balanceText(String amount) =>
      find.textContaining(amount, findRichText: true);

  /// Delivers a backend event and lets bloc + AnimatedSwitcher settle.
  Future<void> deliver(WidgetTester tester, void Function() event) async {
    event();
    await tester.pump(); // stream event → state
    await tester.pumpAndSettle(); // switcher / balance animation
  }

  testWidgets('shows a skeleton until the first snapshot, then the card', (
    tester,
  ) async {
    await pumpSection(tester);
    expect(find.byType(TeacherWalletSkeleton), findsOneWidget);

    await deliver(tester, () => repo.emitWallet(wallet()));

    expect(find.byType(TeacherWalletSkeleton), findsNothing);
    expect(find.byType(TeacherWalletCard), findsOneWidget);
    expect(balanceText('1,323.00'), findsOneWidget);
  });

  testWidgets('live balance change animates from the old to the new value', (
    tester,
  ) async {
    await pumpSection(tester);
    await deliver(tester, () => repo.emitWallet(wallet()));

    repo.emitWallet(wallet(balance: 1500));
    await tester.pump(); // event → cubit state
    await tester.pump(); // rebuild → count-up animation starts
    await tester.pump(const Duration(milliseconds: 300));

    // Mid-animation: neither the old nor the new value.
    expect(balanceText('1,323.00'), findsNothing);
    expect(balanceText('1,500.00'), findsNothing);

    await tester.pumpAndSettle();
    expect(balanceText('1,500.00'), findsOneWidget);
    // Updated in place: still a single card, no skeleton flash.
    expect(find.byType(TeacherWalletCard), findsOneWidget);
  });

  testWidgets('reduced motion shows the new balance immediately', (
    tester,
  ) async {
    await pumpSection(tester, disableAnimations: true);
    await deliver(tester, () => repo.emitWallet(wallet()));

    repo.emitWallet(wallet(balance: 1500));
    await tester.pump();
    await tester.pump();

    expect(balanceText('1,500.00'), findsOneWidget);
  });

  testWidgets('connection loss keeps the last balance and offers a retry', (
    tester,
  ) async {
    await pumpSection(tester);
    await deliver(tester, () => repo.emitWallet(wallet()));
    await deliver(tester, () => repo.emitFailure('boom'));

    expect(balanceText('1,323.00'), findsOneWidget);
    expect(find.byType(TeacherWalletStaleNotice), findsOneWidget);

    await tester.tap(find.byType(TeacherWalletRetryButton));
    await tester.pump();
    expect(repo.watchCalls, 2);

    await deliver(tester, () => repo.emitWallet(wallet(balance: 2000)));
    expect(find.byType(TeacherWalletStaleNotice), findsNothing);
    expect(balanceText('2,000.00'), findsOneWidget);
  });

  testWidgets('failure without data shows an error card with retry', (
    tester,
  ) async {
    await pumpSection(tester);
    await deliver(tester, () => repo.emitFailure('boom'));

    expect(find.byType(TeacherWalletErrorCard), findsOneWidget);
    expect(find.text('boom'), findsOneWidget);

    await tester.tap(find.byType(TeacherWalletRetryButton));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(repo.watchCalls, 2);
    expect(find.byType(TeacherWalletSkeleton), findsOneWidget);
  });

  // Regression: the status pill used to be hard-coded to "active", so
  // closing the wallet in Firestore never showed up on this card.
  testWidgets('a live status change updates the pill and withdraw action', (
    tester,
  ) async {
    await pumpSection(tester);
    await deliver(tester, () => repo.emitWallet(wallet()));

    expect(find.text(LocaleKeys.statusActive), findsOneWidget);
    expect(find.byType(TeacherWalletWithdrawButton), findsOneWidget);
    expect(find.byType(TeacherWalletWithdrawUnavailableNotice), findsNothing);

    await deliver(tester, () => repo.emitWallet(wallet(status: 'closed')));

    expect(find.text(LocaleKeys.statusActive), findsNothing);
    expect(find.text(LocaleKeys.walletStatusInactive), findsOneWidget);
    expect(find.byType(TeacherWalletWithdrawButton), findsNothing);
    expect(find.byType(TeacherWalletWithdrawUnavailableNotice), findsOneWidget);
    expect(find.text(LocaleKeys.walletWithdrawUnavailableTitle), findsOne);

    // Reactivated → the action comes back.
    await deliver(tester, () => repo.emitWallet(wallet()));
    expect(find.byType(TeacherWalletWithdrawButton), findsOneWidget);
    expect(find.byType(TeacherWalletWithdrawUnavailableNotice), findsNothing);
  });

  testWidgets('suspended wallets show their own label and no withdraw', (
    tester,
  ) async {
    await pumpSection(tester);
    await deliver(tester, () => repo.emitWallet(wallet(status: 'suspended')));

    expect(find.text(LocaleKeys.walletStatusSuspended), findsOneWidget);
    expect(find.byType(TeacherWalletWithdrawButton), findsNothing);
    expect(find.byType(TeacherWalletWithdrawUnavailableNotice), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Core/Themes/app_theme.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/withdraw/teacher_withdraw_access_gate.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/withdraw/teacher_withdraw_unavailable_body.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/teacher_wallet_cubit/teacher_wallet_cubit.dart';
import 'package:sintir/locale_keys.dart';

import 'wallet_test_fakes.dart';

/// Stands in for the withdraw form; counts how often its state is created.
class _FakeForm extends StatefulWidget {
  const _FakeForm();

  static int created = 0;

  @override
  State<_FakeForm> createState() => _FakeFormState();
}

class _FakeFormState extends State<_FakeForm> {
  @override
  void initState() {
    super.initState();
    _FakeForm.created++;
  }

  @override
  Widget build(BuildContext context) => const Text('withdraw-form');
}

void main() {
  late FakeTeacherLiveWalletRepo repo;

  Future<void> pumpGate(
    WidgetTester tester, {
    required TeacherWalletEntity initialWallet,
  }) async {
    _FakeForm.created = 0;
    repo = FakeTeacherLiveWalletRepo();
    final cubit = TeacherWalletCubit(walletRepo: repo, teacherId: teacherId)
      ..watchWallet();
    addTearDown(cubit.close);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: Scaffold(
          body: BlocProvider.value(
            value: cubit,
            child: TeacherWithdrawAccessGate(
              initialWallet: initialWallet,
              child: const _FakeForm(),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> deliver(WidgetTester tester, TeacherWalletEntity value) async {
    repo.emitWallet(value);
    await tester.pump();
    await tester.pump();
  }

  testWidgets('an inactive wallet never reaches the form', (tester) async {
    await pumpGate(tester, initialWallet: wallet(status: 'closed'));

    expect(find.text('withdraw-form'), findsNothing);
    expect(find.byType(TeacherWithdrawUnavailableBody), findsOneWidget);
    expect(find.text(LocaleKeys.walletWithdrawUnavailableTitle), findsOne);
    expect(find.text(LocaleKeys.walletWithdrawUnavailableBack), findsOne);
    expect(_FakeForm.created, 0);
  });

  testWidgets('locks the form if the wallet is closed while it is open', (
    tester,
  ) async {
    await pumpGate(tester, initialWallet: wallet());
    expect(find.text('withdraw-form'), findsOneWidget);

    await deliver(tester, wallet(status: 'closed'));

    expect(find.text('withdraw-form'), findsNothing);
    expect(find.byType(TeacherWithdrawUnavailableBody), findsOneWidget);
  });

  testWidgets('balance-only updates keep the form state intact', (
    tester,
  ) async {
    await pumpGate(tester, initialWallet: wallet());
    await deliver(tester, wallet(balance: 900));
    await deliver(tester, wallet(balance: 800));

    expect(find.text('withdraw-form'), findsOneWidget);
    expect(_FakeForm.created, 1, reason: 'form must not be recreated');
  });

  testWidgets('a stale snapshot does not block; live data decides', (
    tester,
  ) async {
    // Opened from a card that was still showing "closed", but the live
    // wallet is active again.
    await pumpGate(tester, initialWallet: wallet(status: 'closed'));
    await deliver(tester, wallet());

    expect(find.text('withdraw-form'), findsOneWidget);
  });
}

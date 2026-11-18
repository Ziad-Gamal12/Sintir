import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/teacher_wallet_cubit/teacher_wallet_cubit.dart';

import 'wallet_test_fakes.dart';

void main() {
  late FakeTeacherLiveWalletRepo repo;
  late TeacherWalletCubit cubit;
  late List<TeacherWalletState> states;

  setUp(() {
    repo = FakeTeacherLiveWalletRepo();
    cubit = TeacherWalletCubit(walletRepo: repo, teacherId: teacherId);
    states = [];
    cubit.stream.listen(states.add);
  });

  tearDown(() => cubit.close());

  test('starts loading and does not listen until asked', () {
    expect(cubit.state, const TeacherWalletLoading());
    expect(repo.watchCalls, 0);
  });

  test('watches the given teacher and shows each live update', () async {
    cubit.watchWallet();
    expect(repo.requestedTeacherIds, [teacherId]);

    repo.emitWallet(wallet());
    await pumpEventQueue();
    repo.emitWallet(wallet(balance: 1500));
    await pumpEventQueue();

    expect(states, [
      TeacherWalletLoaded(wallet()),
      TeacherWalletLoaded(wallet(balance: 1500)),
    ]);
  });

  test('identical wallets do not emit a new state', () async {
    cubit.watchWallet();
    repo.emitWallet(wallet());
    repo.emitWallet(wallet());
    await pumpEventQueue();

    expect(states, [TeacherWalletLoaded(wallet())]);
  });

  test('failure before any data has no wallet to fall back on', () async {
    cubit.watchWallet();
    repo.emitFailure('boom');
    await pumpEventQueue();

    expect(cubit.state, const TeacherWalletFailure(message: 'boom'));
  });

  test('failure after data keeps the last known wallet', () async {
    cubit.watchWallet();
    repo.emitWallet(wallet());
    await pumpEventQueue();
    repo.emitFailure('boom');
    await pumpEventQueue();

    expect(
      cubit.state,
      TeacherWalletFailure(message: 'boom', wallet: wallet()),
    );
  });

  test(
    'retry replaces the old listener and keeps the wallet on screen',
    () async {
      cubit.watchWallet();
      repo.emitWallet(wallet());
      await pumpEventQueue();
      repo.emitFailure('boom');
      await pumpEventQueue();

      cubit.watchWallet();
      await pumpEventQueue();

      expect(repo.watchCalls, 2);
      expect(repo.controllers.first.hasListener, isFalse);
      expect(repo.controllers.last.hasListener, isTrue);
      expect(
        states.whereType<TeacherWalletLoading>(),
        isEmpty,
        reason: 'no skeleton flash while a wallet is already shown',
      );

      repo.emitWallet(wallet(balance: 900));
      await pumpEventQueue();
      expect(cubit.state, TeacherWalletLoaded(wallet(balance: 900)));
    },
  );

  test('retry without data goes back to loading', () async {
    cubit.watchWallet();
    repo.emitFailure('boom');
    await pumpEventQueue();

    cubit.watchWallet();
    await pumpEventQueue();

    expect(cubit.state, const TeacherWalletLoading());
  });

  test('close stops listening', () async {
    cubit.watchWallet();
    await cubit.close();

    expect(repo.latest.hasListener, isFalse);
    // Late events from the backend must not hit the closed cubit.
    repo.emitWallet(wallet());
    await pumpEventQueue();
  });
}

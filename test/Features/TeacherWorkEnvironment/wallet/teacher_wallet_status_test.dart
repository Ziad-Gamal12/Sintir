import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletStatus.dart';

import 'wallet_test_fakes.dart';

void main() {
  group('TeacherWalletStatus.fromRaw', () {
    test('recognizes active and suspended, ignoring case and spaces', () {
      expect(TeacherWalletStatus.fromRaw('active'), TeacherWalletStatus.active);
      expect(
        TeacherWalletStatus.fromRaw(' ACTIVE '),
        TeacherWalletStatus.active,
      );
      expect(
        TeacherWalletStatus.fromRaw('Suspended'),
        TeacherWalletStatus.suspended,
      );
    });

    test('closed, missing and unknown values are inactive (fail closed)', () {
      for (final raw in ['closed', null, '', 'actve', 'frozen']) {
        expect(
          TeacherWalletStatus.fromRaw(raw),
          TeacherWalletStatus.inactive,
          reason: 'raw=$raw',
        );
      }
    });
  });

  test('only active wallets can withdraw', () {
    expect(wallet().canWithdraw, isTrue);
    expect(wallet(status: 'suspended').canWithdraw, isFalse);
    expect(wallet(status: 'closed').canWithdraw, isFalse);
    expect(wallet(status: 'something-new').canWithdraw, isFalse);
  });

  test('a status change makes the wallet unequal (so it is re-emitted)', () {
    expect(wallet(), isNot(wallet(status: 'closed')));
  });
}

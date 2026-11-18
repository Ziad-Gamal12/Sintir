import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/data/Repos/TeacherLiveWalletRepoImpl.dart';
import 'package:sintir/locale_keys.dart';

import 'wallet_test_fakes.dart';

void main() {
  // LocaleKeys resolve through the widgets binding.
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeRealtimeDataBaseService database;
  late TeacherLiveWalletRepoImpl repo;
  late List<WalletResult> results;
  late StreamSubscription<WalletResult> subscription;

  setUp(() {
    database = FakeRealtimeDataBaseService();
    repo = TeacherLiveWalletRepoImpl(realtimeDataBaseService: database);
    results = [];
    subscription = repo.watchWallet(teacherId: teacherId).listen(results.add);
  });

  tearDown(() => subscription.cancel());

  Future<void> push(Map<String, dynamic>? document) async {
    database.controller.add(document);
    await pumpEventQueue();
  }

  String failureMessage(WalletResult result) =>
      result.fold((failure) => failure.message, (_) => fail('expected Left'));

  test('listens to the teacher document in the Users collection', () {
    expect(
      database.lastRequirements?.collection,
      BackendEndpoints.usersCollectionName,
    );
    expect(database.lastRequirements?.docId, teacherId);
  });

  test('maps the nested wallet to an entity', () async {
    await push(userDocument());

    expect(results, hasLength(1));
    expect(results.single.isRight(), isTrue);
    results.single.fold((_) => fail('expected Right'), (value) {
      expect(value, wallet());
      expect(value.balance, 1323);
      expect(value.payoutPending, 250);
      expect(value.createdAt.isAtSameMomentAs(DateTime.utc(2024)), isTrue);
    });
  });

  test('emits again only when the wallet itself changes', () async {
    await push(userDocument());
    // Profile edit: same wallet, different unrelated field.
    await push(userDocument(firstName: 'Renamed'));
    await push(userDocument(balance: 1500));

    expect(results, hasLength(2));
    results.last.fold(
      (_) => fail('expected Right'),
      (value) => expect(value.balance, 1500),
    );
  });

  test('missing document reports wallet-not-found', () async {
    await push(null);
    expect(failureMessage(results.single), LocaleKeys.walletNotFoundError);
  });

  test('user without a wallet map reports wallet-not-found', () async {
    await push({
      'uid': teacherId,
      'teacherExtraData': {'subject': 'Math'},
    });
    expect(failureMessage(results.single), LocaleKeys.walletNotFoundError);
  });

  test('empty wallet map reports wallet-empty', () async {
    await push({
      'uid': teacherId,
      'teacherExtraData': {'wallet': <String, dynamic>{}},
    });
    expect(failureMessage(results.single), LocaleKeys.walletDocumentEmptyError);
  });

  test('malformed wallet becomes a failure instead of throwing', () async {
    final document = userDocument();
    (document['teacherExtraData'] as Map)['wallet']['wallet_id'] =
        'not-a-number';

    await push(document);
    expect(failureMessage(results.single), LocaleKeys.errorOccurredMessage);
  });

  test('listener errors become a failure value', () async {
    database.controller.addError(StateError('permission-denied'));
    await pumpEventQueue();

    expect(failureMessage(results.single), LocaleKeys.errorOccurredMessage);
  });

  test('recovers when the wallet appears after a failure', () async {
    await push(null);
    await push(userDocument());

    expect(results.first.isLeft(), isTrue);
    expect(results.last.isRight(), isTrue);
  });
}

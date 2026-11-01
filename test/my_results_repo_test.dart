import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStorePaginateResponse.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Features/MyResults/Data/Repo/my_results_repo_impl.dart';

void main() {
  test('refresh invalidates the cached overview and reads updated data',
      () async {
    final database = _FakeDataBaseService();
    final repo = MyResultsRepoImpl(dataBaseService: database);

    final firstPage =
        await repo.getMyResults(userId: 'student', isPaginate: false);
    final firstResponse = firstPage.fold(
      (failure) => throw StateError(failure.message),
      (response) => response,
    );
    expect(firstResponse.totalCount, 2);
    expect(firstResponse.overallAveragePercent, 75);
    expect(firstResponse.hasMore, isTrue);
    expect(database.countCalls, 1);
    expect(database.fullCollectionCalls, 1);

    final nextPage =
        await repo.getMyResults(userId: 'student', isPaginate: true);
    expect(nextPage.isRight(), isTrue);
    expect(database.countCalls, 1);
    expect(database.fullCollectionCalls, 1);

    database.resultCount = 3;
    database.overviewDocuments = [
      {
        'totalQuestions': 4,
        'questionsSolvedList': [
          {'isCorrect': true},
          {'isCorrect': true},
          {'isCorrect': true},
          {'isCorrect': true},
        ],
      },
      {
        'totalQuestions': 2,
        'questionsSolvedList': [
          {'isCorrect': false},
          {'isCorrect': false},
        ],
      },
      {
        'totalQuestions': 4,
        'questionsSolvedList': [
          {'isCorrect': true},
          {'isCorrect': true},
          {'isCorrect': false},
          {'isCorrect': false},
        ],
      },
    ];
    final refreshed =
        await repo.getMyResults(userId: 'student', isPaginate: false);
    final refreshedResponse = refreshed.fold(
      (failure) => throw StateError(failure.message),
      (response) => response,
    );
    expect(refreshedResponse.totalCount, 3);
    expect(refreshedResponse.overallAveragePercent, 50);
    expect(database.countCalls, 2);
    expect(database.fullCollectionCalls, 2);
  });
}

class _FakeDataBaseService implements DataBaseService {
  int countCalls = 0;
  int fullCollectionCalls = 0;
  int resultCount = 2;
  List<Map<String, dynamic>> overviewDocuments = [
    {
      'totalQuestions': 4,
      'questionsSolvedList': [
        {'isCorrect': true},
        {'isCorrect': true},
        {'isCorrect': false},
        {'isCorrect': false},
      ],
    },
    {
      'totalQuestions': 2,
      'questionsSolvedList': [
        {'isCorrect': true},
        {'isCorrect': true},
      ],
    },
  ];

  @override
  Future<FireStoreResponse> getData({
    required FireStoreRequirmentsEntity requirements,
    Map<String, dynamic>? query,
  }) async {
    if (query?.containsKey('limit') ?? false) {
      return FireStoreResponse(listData: const []);
    }
    fullCollectionCalls++;
    return FireStoreResponse(listData: overviewDocuments);
  }

  @override
  Future<int> getCollectionItemsCount({
    required FireStoreRequirmentsEntity requirements,
    Map<String, dynamic>? query,
  }) async {
    countCalls++;
    return resultCount;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

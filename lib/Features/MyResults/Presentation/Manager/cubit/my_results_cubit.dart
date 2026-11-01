import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Features/MyResults/Domain/Entities/get_my_results_response_entity.dart';
import 'package:sintir/Features/MyResults/Domain/Repo/my_results_repo.dart';

part 'my_results_state.dart';

class MyResultsCubit extends Cubit<MyResultsState> {
  MyResultsCubit({required this.myResultsRepo}) : super(MyResultsInitial());
  final MyResultsRepo myResultsRepo;
  Future<void>? _activeRequest;
  Future<void>? _pendingRefresh;
  bool _refreshQueued = false;
  List<TestResultEntity> _results = const [];
  int _totalCount = 0;
  int _average = 0;
  bool _hasMore = true;

  Future<void> getMyResults(
      {required String userId, required bool isPaginate}) {
    final currentState = state;
    if (isPaginate) {
      if (_activeRequest != null ||
          _pendingRefresh != null ||
          currentState is GetMyResultsLoading ||
          (currentState is GetMyResultsSuccess && !currentState.hasMore)) {
        return Future<void>.value();
      }
      return _runTrackedRequest(userId: userId, isPaginate: true);
    }

    final pendingRefresh = _pendingRefresh;
    if (pendingRefresh != null) return pendingRefresh;
    if (_activeRequest != null) _refreshQueued = true;

    late final Future<void> refresh;
    refresh = _refreshAfterActiveRequest(userId).whenComplete(() {
      if (identical(_pendingRefresh, refresh)) _pendingRefresh = null;
    });
    _pendingRefresh = refresh;
    return refresh;
  }

  Future<void> _refreshAfterActiveRequest(String userId) async {
    final activeRequest = _activeRequest;
    if (activeRequest != null) await activeRequest;
    if (isClosed) return;
    _refreshQueued = false;
    await _runTrackedRequest(userId: userId, isPaginate: false);
  }

  Future<void> _runTrackedRequest(
      {required String userId, required bool isPaginate}) async {
    final request = _runRequest(userId: userId, isPaginate: isPaginate);
    _activeRequest = request;
    try {
      await request;
    } finally {
      if (identical(_activeRequest, request)) _activeRequest = null;
    }
  }

  Future<void> _runRequest(
      {required String userId, required bool isPaginate}) async {
    emit(GetMyResultsLoading(
        isPaginate: isPaginate,
        results: _results,
        totalCount: _totalCount,
        overallAveragePercent: _average,
        hasMore: _hasMore));
    final result = await myResultsRepo.getMyResults(
        userId: userId, isPaginate: isPaginate);
    if (isPaginate && _refreshQueued) return;
    result.fold(
        (failure) => emit(GetMyResultsFailure(
            errMessage: failure.message,
            results: _results,
            totalCount: _totalCount,
            overallAveragePercent: _average,
            hasMore: _hasMore)), (response) {
      _results = response.isPaginate
          ? [..._results, ...response.results]
          : response.results;
      _totalCount = response.totalCount;
      _average = response.overallAveragePercent;
      _hasMore = response.hasMore;
      emit(GetMyResultsSuccess(
          getMyResultsResponseEntity: response, results: _results));
    });
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/FetchDataResponses/CourseReportsSummaryEntity.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetCourseReportsResponseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/CourseReportsRepo/CourseReportsRepo.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/SendCourseReportEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/report_enums.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/UseCases/UpdateCourseReportStatusUseCase.dart';
import 'package:sintir/locale_keys.dart';

part 'course_reports_state.dart';

class CourseReportsFilter {
  final ReportStatus? status;
  final ReportType? type;
  final ReportSortOrder sortOrder;
  const CourseReportsFilter(
      {this.status, this.type, this.sortOrder = ReportSortOrder.newestFirst});
}

class CourseReportsCubit extends Cubit<CourseReportsState> {
  CourseReportsCubit({required this.coursereportsrepo})
      : updateStatusUseCase =
            UpdateCourseReportStatusUseCase(coursereportsrepo),
        super(const CourseReportsInitial());

  final CourseReportsRepo coursereportsrepo;
  final UpdateCourseReportStatusUseCase updateStatusUseCase;
  final Set<String> _normalizedCourseIds = {};
  List<CourseReportsItemEntity> _reports = [];
  CourseReportsSummaryEntity _summary = const CourseReportsSummaryEntity();
  String courseId = '';
  String courseTitle = '';
  ReportStatus? _statusFilter;
  ReportType? _typeFilter;
  ReportSortOrder _sortOrder = ReportSortOrder.newestFirst;
  String _searchQuery = '';
  bool _hasMore = false;
  bool _isLoadingMore = false;
  bool _fetching = false;
  bool _reloadPending = false;
  int _requestVersion = 0;

  List<CourseReportsItemEntity> get reports => List.unmodifiable(_reports);
  List<CourseReportsItemEntity> get visibleReports {
    final needle = _searchQuery.trim().toLowerCase();
    return needle.isEmpty
        ? reports
        : List.unmodifiable(_reports.where(
            (report) => report.description.toLowerCase().contains(needle)));
  }

  CourseReportsSummaryEntity get summary => _summary;
  CourseReportsFilter get filter => CourseReportsFilter(
      status: _statusFilter, type: _typeFilter, sortOrder: _sortOrder);
  ReportStatus? get statusFilter => _statusFilter;
  ReportType? get typeFilter => _typeFilter;
  ReportSortOrder get sortOrder => _sortOrder;
  String get searchQuery => _searchQuery;
  bool get hasMore => _hasMore;
  bool get isLoadingMore => _isLoadingMore;
  bool get isLoading => _fetching;
  CourseReportsItemEntity? reportById(String id) {
    for (final report in _reports) {
      if (report.id == id) return report;
    }
    return null;
  }

  Future<void> loadInitial({required String courseId}) async {
    this.courseId = courseId;
    _reports = [];
    _summary = const CourseReportsSummaryEntity();
    _hasMore = false;
    _searchQuery = '';
    await _fetchFirstPage(
        normalize: !_normalizedCourseIds.contains(courseId), loadTitle: true);
  }

  Future<void> addCourseReport({
    required SendCourseReportEntity reportEntity,
  }) async {
    if (isClosed) return;
    emit(const CourseReportsAddReportLoading());
    final result =
        await coursereportsrepo.addCourseReport(report: reportEntity);
    if (isClosed) return;
    result.fold(
      (failure) =>
          emit(CourseReportsAddReportFailure(errMessage: failure.message)),
      (_) => emit(const CourseReportsAddReportSuccess()),
    );
  }

  Future<void> getCourseReports(
      {required String courseId, required bool isPaginate}) async {
    this.courseId = courseId;
    if (isPaginate) {
      await loadMore();
    } else {
      await refresh();
    }
  }

  Future<void> refresh() => _fetchFirstPage();

  Future<void> applyFilters(
      {ReportStatus? status,
      ReportType? type,
      ReportSortOrder? sortOrder}) async {
    _statusFilter = status;
    _typeFilter = type;
    if (sortOrder != null) _sortOrder = sortOrder;
    _reports = [];
    _hasMore = false;
    await _fetchFirstPage();
  }

  Future<void> clearFilters() async {
    _statusFilter = null;
    _typeFilter = null;
    _sortOrder = ReportSortOrder.newestFirst;
    _searchQuery = '';
    _reports = [];
    _hasMore = false;
    await _fetchFirstPage();
  }

  void setSearchQuery(String value) {
    _searchQuery = value;
    _emitViewChange();
  }

  Future<void> _fetchFirstPage(
      {bool normalize = false, bool loadTitle = false}) async {
    _requestVersion++;
    if (_fetching) {
      _reloadPending = true;
      emit(CourseReportsGetReportLoading(reports: reports));
      return;
    }
    _fetching = true;
    final version = _requestVersion;
    emit(const CourseReportsGetReportLoading());
    try {
      if (normalize) {
        await coursereportsrepo.normalizeLegacyReports(courseId: courseId);
        if (isClosed) return;
        _normalizedCourseIds.add(courseId);
      }
      final summaryFuture =
          coursereportsrepo.getCourseReportsSummary(courseId: courseId);
      final reportsFuture = coursereportsrepo.getCourseReports(
          courseId: courseId,
          isPaginate: false,
          status: _statusFilter,
          type: _typeFilter,
          sortOrder: _sortOrder);
      final titleFuture = loadTitle
          ? coursereportsrepo.getCourseTitle(courseId: courseId)
          : null;
      await Future.wait<Object>(
          [summaryFuture, reportsFuture, if (titleFuture != null) titleFuture]);
      if (isClosed || version != _requestVersion) return;
      final Either<Failure, CourseReportsSummaryEntity> summaryResult =
          await summaryFuture;
      final Either<Failure, GetCourseReportsResponseEntity> reportsResult =
          await reportsFuture;
      summaryResult.fold((failure) => _emitFailure(failure.message),
          (value) => _summary = value);
      reportsResult.fold((failure) => _emitFailure(failure.message),
          (response) {
        _reports = response.reports;
        _hasMore = response.hasMore;
      });
      if (summaryResult.isLeft() || reportsResult.isLeft()) return;
      if (titleFuture != null) {
        final titleResult = await titleFuture;
        titleResult.fold((_) {}, (title) => courseTitle = title);
      }
      _emitLoaded(isPaginate: false);
    } catch (_) {
      if (!isClosed && version == _requestVersion) {
        _emitFailure(LocaleKeys.errorOccurredMessage);
      }
    } finally {
      _fetching = false;
      _finishPendingReload();
    }
  }

  Future<void> loadMore() async {
    if (_fetching || _isLoadingMore || !_hasMore || courseId.isEmpty) return;
    _fetching = true;
    _isLoadingMore = true;
    final version = _requestVersion;
    emit(CourseReportsGetReportLoading(isPaginate: true, reports: reports));
    try {
      final result = await coursereportsrepo.getCourseReports(
          courseId: courseId,
          isPaginate: true,
          status: _statusFilter,
          type: _typeFilter,
          sortOrder: _sortOrder);
      if (isClosed || version != _requestVersion) return;
      result.fold((failure) => _emitFailure(failure.message), (response) {
        final knownIds = _reports.map((report) => report.id).toSet();
        _reports = [
          ..._reports,
          ...response.reports.where((report) => knownIds.add(report.id))
        ];
        _hasMore = response.hasMore;
        _emitLoaded(isPaginate: true, pageReports: response.reports);
      });
    } catch (_) {
      if (!isClosed && version == _requestVersion) {
        _emitFailure(LocaleKeys.errorOccurredMessage);
      }
    } finally {
      _fetching = false;
      _isLoadingMore = false;
      _finishPendingReload();
    }
  }

  Future<void> updateReportStatus(
      {required String courseId,
      required String reportId,
      required ReportStatus newStatus}) async {
    emit(CourseReportsUpdateStatusLoading());
    final current = reportById(reportId);
    if (current == null || current.status == newStatus) return;
    final previousReports = _reports;
    final previousSummary = _summary;
    _reports = _reports
        .map((report) => report.id == reportId
            ? report.copyWith(
                status: newStatus,
                resolvedAt:
                    newStatus == ReportStatus.open ? null : DateTime.now(),
                clearResolvedAt: newStatus == ReportStatus.open,
              )
            : report)
        .where(
            (report) => _statusFilter == null || report.status == _statusFilter)
        .toList();
    _summary = _summary.moved(current.status, newStatus);
    _emitLoaded(isPaginate: false);
    final result = await updateStatusUseCase(
        courseId: courseId, reportId: reportId, status: newStatus);
    if (isClosed) return;
    result.fold((failure) {
      _reports = previousReports;
      _summary = previousSummary;
      emit(CourseReportsUpdateStatusFailure(
          errMessage: failure.message, reports: reports));
    },
        (_) => emit(CourseReportsUpdateStatusSuccess(
            reports: reports, summary: summary)));
  }

  void _emitLoaded(
      {required bool isPaginate, List<CourseReportsItemEntity>? pageReports}) {
    final response = GetCourseReportsResponseEntity(
        reports: pageReports ?? reports,
        hasMore: _hasMore,
        isPaginate: isPaginate);
    emit(CourseReportsGetReportSuccess(
        response: response,
        reports: reports,
        summary: summary,
        courseTitle: courseTitle));
  }

  void _emitFailure(String message) => emit(
      CourseReportsGetReportFailure(errMessage: message, reports: reports));
  void _emitViewChange() {
    if (state is CourseReportsGetReportSuccess) _emitLoaded(isPaginate: false);
  }

  void _finishPendingReload() {
    if (_reloadPending && !isClosed) {
      _reloadPending = false;
      unawaited(_fetchFirstPage());
    }
  }
}

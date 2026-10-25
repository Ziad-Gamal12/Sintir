// ignore_for_file: file_names, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetCourseSubscribersEntity.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Core/repos/CourseSubscibtionsRepo/CourseSubscibtionsRepo.dart';
import 'package:sintir/Core/repos/PaymobRepo.dart/PaymobRepo.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/PayMobResponse.dart';
import 'package:sintir/locale_keys.dart';

part 'CourseSubscribtionsState.dart';

class CourseSubscribtionsCubit extends Cubit<CourseSubscribtionsState> {
  CourseSubscribtionsCubit({
    required this.subscribtionRepo,
    required this.course,
    required this.paymobRepo,
  }) : super(SubscribeToCoursesInitial());
  final CourseSubscibtionsRepo subscribtionRepo;
  final PaymobRepo paymobRepo;
  final CourseEntity course;
  int _searchRequestId = 0;
  String _activeSearchKeyword = '';
  bool _normalPageLoading = false;
  bool _searchPageLoading = false;
  bool _normalHasMore = true;
  bool _searchHasMore = true;

  void invalidateSubscriberSearch() {
    _searchRequestId++;
    _searchPageLoading = false;
    _activeSearchKeyword = '';
  }

  void subscribeToCourse(
      {required UserEntity userEntity,
      required TransactionEntity transactionEntity,
      required double amount}) async {
    emit(SubscibeingToCourseLoading());
    var result = await subscribtionRepo.subscribeToCourse(
        amount: amount,
        transactionId: transactionEntity.transactionId,
        transactionEntity: transactionEntity,
        course: course,
        userEntity: userEntity);
    result.fold((failure) {
      emit(SubscibeingToCourseFailure(errMessge: failure.message));
    }, (message) {
      emit(SubscibeingToCourseSuccess());
    });
  }

  Future<void> payWithWallet({
    required UserEntity userEntity,
    required double amount,
  }) async {
    emit(PayWithWalletLoading());
    var result = await paymobRepo.payWithWallet(
        user: userEntity, course: course, amount: amount);
    result.fold((failure) {
      emit(PayWithWalletFailure(errMessage: failure.message));
    }, (response) {
      emit(PayWithWalletSuccess(response: response));
    });
  }

  Future<void> checkIfSubscribed() async {
    emit(CheckIfSubscribedLoading());
    try {
      final result = await subscribtionRepo.checkIfSubscribed(
          courseID: course.id);
      result.fold((failure) {
        emit(CheckIfSubscribedFailure(errMessage: failure.message));
      }, (isSubscribed) {
        emit(CheckIfSubscribedSuccess(isSubscribed: isSubscribed));
      });
    } catch (_) {
      emit(CheckIfSubscribedFailure(
          errMessage: LocaleKeys.errorOccurredMessage));
    }
  }

  Future<void> getCoursSubscribers({required bool isPaginate}) async {
    if (isPaginate && (_normalPageLoading || !_normalHasMore)) return;
    _normalPageLoading = true;
    emit(GetCourseSubscribersLoading(
      isPaginate: isPaginate,
    ));
    try {
      final result = await subscribtionRepo.getSubscribers(
          courseID: course.id, isPaginate: isPaginate);
      result.fold((failure) {
        emit(GetCourseSubscribersFailure(errMessage: failure.message));
      }, (response) {
        _normalHasMore = response.hasMore && response.subscribers.isNotEmpty;
        emit(GetCourseSubscribersSuccess(response: response));
      });
    } finally {
      _normalPageLoading = false;
    }
  }

  Future<void> searchSubscribers(
      {required String keyword, required bool isPaginate}) async {
    final normalizedKeyword = keyword.trim();
    if (normalizedKeyword.isEmpty) return;
    if (!isPaginate) {
      if (normalizedKeyword == _activeSearchKeyword) return;
      _activeSearchKeyword = normalizedKeyword;
      _searchRequestId++;
      _searchHasMore = true;
      _searchPageLoading = false;
    } else if (_searchPageLoading ||
        !_searchHasMore ||
        normalizedKeyword != _activeSearchKeyword) {
      return;
    }
    final requestId = _searchRequestId;
    _searchPageLoading = true;
    emit(SearchSubscribersLoading(
      isPaginate: isPaginate,
    ));
    try {
      final result = await subscribtionRepo.searchSubscribers(
          searchKey: normalizedKeyword,
          isPaginate: isPaginate,
          courseID: course.id);
      if (requestId != _searchRequestId ||
          normalizedKeyword != _activeSearchKeyword) {
        return;
      }
      result.fold((failure) {
        emit(SearchSubscribersFailure(errMessage: failure.message));
      }, (response) {
        _searchHasMore = response.hasMore && response.subscribers.isNotEmpty;
        emit(SearchSubscribersSuccess(response: response));
      });
    } finally {
      if (requestId == _searchRequestId) {
        _searchPageLoading = false;
      }
    }
  }
}

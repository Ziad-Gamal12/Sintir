import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Features/MyTransactions/Domain/Entities/GetMyTransactionsResponseEntity.dart';
import 'package:sintir/Features/MyTransactions/Domain/Repos/MyTransactionsRep.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Enums/TransactionsStatusEnum.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/styles/transaction_method_mapper.dart';

part 'my_transactions_state.dart';

class MyTransactionsCubit extends Cubit<MyTransactionsState> {
  MyTransactionsCubit({required this.myTransactionsRep})
    : super(const MyTransactionsState());
  final MyTransactionsRepo myTransactionsRep;
  Timer? _searchDebounce;
  bool _requestInFlight = false;

  Future<void> getMyTransactions({
    required String userId,
    required bool isPaginate,
  }) async {
    if (_requestInFlight || (isPaginate && !state.hasMore)) return;
    _requestInFlight = true;
    emit(
      state.copyWith(
        isLoading: !isPaginate,
        isPaginating: isPaginate,
        clearError: true,
      ),
    );
    final result = await myTransactionsRep.getMyTransactions(
      userId: userId,
      isPaginate: isPaginate,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          isPaginating: false,
          error: failure.message,
        ),
      ),
      (GetMyTransactionsResponseEntity response) {
        final items = isPaginate
            ? [...state.transactions, ...response.transactions]
            : response.transactions;
        emit(
          state.copyWith(
            transactions: List.unmodifiable(items),
            hasMore: response.hasMore,
            isLoading: false,
            isPaginating: false,
            isSystemConnected: true,
          ),
        );
      },
    );
    _requestInFlight = false;
  }

  void search(String query) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(
      const Duration(milliseconds: 300),
      () => emit(state.copyWith(searchQuery: query)),
    );
  }

  void setStatusFilter(TransactionsStatus? status) => emit(
    state.copyWith(statusFilter: status, clearStatusFilter: status == null),
  );
  void applyFilters({
    TransactionsStatus? status,
    required Set<String> methods,
    required TransactionsDateRange range,
    DateTime? start,
    DateTime? end,
    required bool newestFirst,
  }) => emit(
    state.copyWith(
      statusFilter: status,
      clearStatusFilter: status == null,
      paymentMethods: Set.unmodifiable(methods),
      dateRange: range,
      customStart: start,
      customEnd: end,
      clearCustomRange: start == null && end == null,
      newestFirst: newestFirst,
    ),
  );
  int previewCount({
    TransactionsStatus? status,
    required Set<String> methods,
    required TransactionsDateRange range,
    DateTime? start,
    DateTime? end,
    required bool newestFirst,
  }) => state
      .copyWith(
        statusFilter: status,
        clearStatusFilter: status == null,
        paymentMethods: methods,
        dateRange: range,
        customStart: start,
        customEnd: end,
        clearCustomRange: start == null && end == null,
        newestFirst: newestFirst,
      )
      .filteredTransactions
      .length;
  void clearFilters() => emit(
    state.copyWith(
      clearStatusFilter: true,
      paymentMethods: const {},
      dateRange: TransactionsDateRange.all,
      clearCustomRange: true,
      newestFirst: true,
      searchQuery: '',
    ),
  );

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }
}

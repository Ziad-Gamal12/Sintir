part of 'my_transactions_cubit.dart';

@immutable
class MyTransactionsState {
  const MyTransactionsState(
      {this.transactions = const [],
      this.isLoading = false,
      this.isPaginating = false,
      this.hasMore = true,
      this.error,
      this.searchQuery = '',
      this.statusFilter,
      this.paymentMethods = const {},
      this.dateRange = TransactionsDateRange.all,
      this.customStart,
      this.customEnd,
      this.newestFirst = true});
  final List<TransactionEntity> transactions;
  final bool isLoading, isPaginating, hasMore, newestFirst;
  final String? error;
  final String searchQuery;
  final TransactionsStatus? statusFilter;
  final Set<String> paymentMethods;
  final TransactionsDateRange dateRange;
  final DateTime? customStart, customEnd;

  List<TransactionEntity> get filteredTransactions {
    final query = searchQuery.trim().toLowerCase();
    final now = DateTime.now();
    final start = switch (dateRange) {
      TransactionsDateRange.today => DateTime(now.year, now.month, now.day),
      TransactionsDateRange.last7Days => now.subtract(const Duration(days: 7)),
      TransactionsDateRange.last30Days =>
        now.subtract(const Duration(days: 30)),
      TransactionsDateRange.custom => customStart,
      TransactionsDateRange.all => null,
    };
    final values = transactions.where((item) {
      if (statusFilter != null && item.status != statusFilter) {
        return false;
      }
      if (paymentMethods.isNotEmpty &&
          !paymentMethods.contains(transactionMethodKey(item.method))) {
        return false;
      }
      if (start != null &&
          (item.createdAt == null || item.createdAt!.isBefore(start))) {
        return false;
      }
      if (dateRange == TransactionsDateRange.custom &&
          customEnd != null &&
          (item.createdAt == null || item.createdAt!.isAfter(customEnd!))) {
        return false;
      }
      if (query.isNotEmpty &&
          !'${item.transactionId} ${item.mobileNumber ?? ''} ${item.method} ${item.issuer ?? ''}'
              .toLowerCase()
              .contains(query)) {
        return false;
      }
      return true;
    }).toList();
    values.sort((a, b) {
      final left = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      final right = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      return newestFirst ? right.compareTo(left) : left.compareTo(right);
    });
    return values;
  }

  int count(TransactionsStatus? status) => status == null
      ? transactions.length
      : transactions.where((item) => item.status == status).length;
  bool get hasActiveFilters =>
      statusFilter != null ||
      paymentMethods.isNotEmpty ||
      dateRange != TransactionsDateRange.all ||
      searchQuery.isNotEmpty;

  List<TransactionDayGroup> get dayGroups {
    final groups = <DateTime, List<TransactionEntity>>{};
    for (final item in filteredTransactions) {
      final date = item.createdAt;
      final key = date == null
          ? DateTime(1)
          : DateTime(date.year, date.month, date.day);
      groups.putIfAbsent(key, () => []).add(item);
    }
    return groups.entries.map((entry) {
      final currencies = entry.value.map((e) => e.currency).toSet();
      final total = currencies.length == 1 &&
              currencies.first != null &&
              entry.value.every((e) => e.amount != null)
          ? entry.value.fold<double>(0, (sum, item) => sum + item.amount!)
          : null;
      return TransactionDayGroup(
          date: entry.key,
          transactions: List.unmodifiable(entry.value),
          total: total,
          currency: currencies.length == 1 ? currencies.first : null);
    }).toList()
      ..sort((a, b) =>
          newestFirst ? b.date.compareTo(a.date) : a.date.compareTo(b.date));
  }

  MyTransactionsState copyWith(
          {List<TransactionEntity>? transactions,
          bool? isLoading,
          bool? isPaginating,
          bool? hasMore,
          String? error,
          bool clearError = false,
          String? searchQuery,
          TransactionsStatus? statusFilter,
          bool clearStatusFilter = false,
          Set<String>? paymentMethods,
          TransactionsDateRange? dateRange,
          DateTime? customStart,
          DateTime? customEnd,
          bool clearCustomRange = false,
          bool? newestFirst}) =>
      MyTransactionsState(
          transactions: transactions ?? this.transactions,
          isLoading: isLoading ?? this.isLoading,
          isPaginating: isPaginating ?? this.isPaginating,
          hasMore: hasMore ?? this.hasMore,
          error: clearError ? null : error ?? this.error,
          searchQuery: searchQuery ?? this.searchQuery,
          statusFilter:
              clearStatusFilter ? null : statusFilter ?? this.statusFilter,
          paymentMethods: paymentMethods ?? this.paymentMethods,
          dateRange: dateRange ?? this.dateRange,
          customStart:
              clearCustomRange ? null : customStart ?? this.customStart,
          customEnd: clearCustomRange ? null : customEnd ?? this.customEnd,
          newestFirst: newestFirst ?? this.newestFirst);
}

@immutable
class TransactionDayGroup {
  const TransactionDayGroup(
      {required this.date,
      required this.transactions,
      required this.total,
      required this.currency});
  final DateTime date;
  final List<TransactionEntity> transactions;
  final double? total;
  final String? currency;
}

enum TransactionsDateRange { all, today, last7Days, last30Days, custom }

String transactionMethodKey(String method) {
  final value = method.toLowerCase();
  if (value.contains('card') || value.contains('بطاقة')) {
    return 'card';
  }
  if (value.contains('wallet') ||
      value.contains('mobile') ||
      value.contains('محفظ')) {
    return 'wallet';
  }
  if (value.contains('fawry') ||
      value.contains('outlet') ||
      value.contains('فوري')) {
    return 'fawry';
  }
  if (value.contains('cash') || value.contains('نقد')) {
    return 'cash';
  }
  if (value.contains('transfer') ||
      value.contains('instapay') ||
      value.contains('bank') ||
      value.contains('تحويل')) {
    return 'transfer';
  }
  return 'other';
}

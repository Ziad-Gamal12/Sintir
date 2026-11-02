import 'package:flutter/material.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Manager/my_transactions_cubit/my_transactions_cubit.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/filter_sheet/transactions_filter_content.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/filter_sheet/filter_date_range_picker.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Enums/TransactionsStatusEnum.dart';

class TransactionsFilterSheet extends StatefulWidget {
  const TransactionsFilterSheet({super.key, required this.cubit});
  final MyTransactionsCubit cubit;

  @override
  State<TransactionsFilterSheet> createState() =>
      _TransactionsFilterSheetState();
}

class _TransactionsFilterSheetState extends State<TransactionsFilterSheet> {
  TransactionsStatus? _status;
  Set<String> _methods = {};
  TransactionsDateRange _range = TransactionsDateRange.last7Days;
  DateTime? _start, _end;
  bool _newestFirst = true;

  @override
  void initState() {
    super.initState();
    final state = widget.cubit.state;
    _status = state.statusFilter;
    _methods = {...state.paymentMethods};
    _range = state.dateRange == TransactionsDateRange.all
        ? TransactionsDateRange.last7Days
        : state.dateRange;
    _start = state.customStart;
    _end = state.customEnd;
    _newestFirst = state.newestFirst;
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.cubit.previewCount(
      status: _status,
      methods: _methods,
      range: _range,
      start: _start,
      end: _end,
      newestFirst: _newestFirst,
    );
    return TransactionsFilterContent(
      status: _status,
      methods: _methods,
      range: _range,
      newestFirst: _newestFirst,
      count: count,
      onStatus: (value) => setState(() => _status = value),
      onMethods: _toggle,
      onRange: (value) => setState(() => _range = value),
      onCustomRange: _pickRange,
      onSort: (value) => setState(() => _newestFirst = value),
      onReset: _reset,
      onApply: _apply,
    );
  }

  void _toggle(String id, bool selected) =>
      setState(() => selected ? _methods.add(id) : _methods.remove(id));
  void _reset() => setState(() {
    _status = null;
    _methods.clear();
    _range = TransactionsDateRange.last7Days;
    _start = null;
    _end = null;
    _newestFirst = true;
  });
  void _apply() {
    widget.cubit.applyFilters(
      status: _status,
      methods: _methods,
      range: _range,
      start: _start,
      end: _end,
      newestFirst: _newestFirst,
    );
    Navigator.pop(context);
  }

  Future<void> _pickRange() async {
    final value = await FilterDateRangePicker.pick(
      context,
      start: _start,
      end: _end,
    );
    if (value != null && mounted) {
      setState(() {
        _start = value.start;
        _end = value.end;
        _range = TransactionsDateRange.custom;
      });
    }
  }
}

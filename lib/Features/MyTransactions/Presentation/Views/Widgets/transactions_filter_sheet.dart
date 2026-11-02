import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Manager/my_transactions_cubit/my_transactions_cubit.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Enums/TransactionsStatusEnum.dart';
import 'package:sintir/locale_keys.dart';

Future<void> showTransactionsFilter(BuildContext context) async {
  final wide = MediaQuery.sizeOf(context).width >= 900;
  final cubit = context.read<MyTransactionsCubit>();
  Widget buildFilterSheet(BuildContext _) =>
      _TransactionsFilterSheet(cubit: cubit);
  if (wide) {
    await showDialog<void>(
        context: context,
        builder: (context) => Dialog(
            child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: 560, maxHeight: 720),
                child: buildFilterSheet(context))));
  } else {
    await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        builder: buildFilterSheet);
  }
}

class _TransactionsFilterSheet extends StatefulWidget {
  const _TransactionsFilterSheet({required this.cubit});
  final MyTransactionsCubit cubit;
  @override
  State<_TransactionsFilterSheet> createState() =>
      _TransactionsFilterSheetState();
}

class _TransactionsFilterSheetState extends State<_TransactionsFilterSheet> {
  late TransactionsStatus? status;
  late Set<String> methods;
  late TransactionsDateRange range;
  DateTime? start, end;
  late bool newestFirst;

  @override
  void initState() {
    super.initState();
    final state = widget.cubit.state;
    status = state.statusFilter;
    methods = {...state.paymentMethods};
    range = state.dateRange == TransactionsDateRange.all
        ? TransactionsDateRange.last7Days
        : state.dateRange;
    start = state.customStart;
    end = state.customEnd;
    newestFirst = state.newestFirst;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final styles = AppTextStyles(context);
    final previewCount = widget.cubit.previewCount(
        status: status,
        methods: methods,
        range: range,
        start: start,
        end: end,
        newestFirst: newestFirst);
    return SafeArea(
        child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 16, 20, 20),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Row(children: [
                Icon(Icons.filter_list_rounded,
                    color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Expanded(
                    child: Text(LocaleKeys.transactionsFilter,
                        style: styles.semiBold20)),
                TextButton(
                    onPressed: _reset,
                    child: Text(LocaleKeys.transactionsReset))
              ]),
              Flexible(
                  child: ListView(shrinkWrap: true, children: [
                _SectionTitle(
                    title: LocaleKeys.transactionsStatus,
                    helper: LocaleKeys.transactionsSingleChoice),
                Wrap(spacing: 8, runSpacing: 8, children: [
                  _Choice(
                      label: LocaleKeys.transactionsAll,
                      selected: status == null,
                      onTap: () => setState(() => status = null)),
                  _Choice(
                      label: LocaleKeys.transactionsSuccess,
                      selected: status == TransactionsStatus.success,
                      onTap: () =>
                          setState(() => status = TransactionsStatus.success)),
                  _Choice(
                      label: LocaleKeys.transactionsFailed,
                      selected: status == TransactionsStatus.failure,
                      onTap: () =>
                          setState(() => status = TransactionsStatus.failure)),
                  _Choice(
                      label: LocaleKeys.transactionsPending,
                      selected: status == TransactionsStatus.pending,
                      onTap: () =>
                          setState(() => status = TransactionsStatus.pending)),
                  _Choice(
                      label: LocaleKeys.transactionsOther,
                      selected: status == TransactionsStatus.other,
                      onTap: () =>
                          setState(() => status = TransactionsStatus.other)),
                ]),
                _SectionTitle(
                    title: LocaleKeys.transactionsPaymentMethods,
                    helper: LocaleKeys.transactionsMultipleChoice),
                Wrap(spacing: 8, runSpacing: 8, children: [
                  _Method(
                      label: LocaleKeys.transactionsBankCard,
                      icon: Icons.credit_card,
                      id: 'card',
                      values: methods,
                      onChanged: _toggle),
                  _Method(
                      label: LocaleKeys.transactionsWallet,
                      icon: Icons.account_balance_wallet_outlined,
                      id: 'wallet',
                      values: methods,
                      onChanged: _toggle),
                  _Method(
                      label: LocaleKeys.transactionsFawry,
                      icon: Icons.storefront_outlined,
                      id: 'fawry',
                      values: methods,
                      onChanged: _toggle),
                  _Method(
                      label: LocaleKeys.transactionsCash,
                      icon: Icons.payments_outlined,
                      id: 'cash',
                      values: methods,
                      onChanged: _toggle),
                  _Method(
                      label: LocaleKeys.transactionsDirectTransfer,
                      icon: Icons.swap_horiz,
                      id: 'transfer',
                      values: methods,
                      onChanged: _toggle,
                      full: true),
                ]),
                _SectionTitle(title: LocaleKeys.transactionsDateRange),
                Wrap(spacing: 8, runSpacing: 8, children: [
                  _Choice(
                      label: LocaleKeys.transactionsToday,
                      selected: range == TransactionsDateRange.today,
                      onTap: () =>
                          setState(() => range = TransactionsDateRange.today)),
                  _Choice(
                      label: LocaleKeys.transactionsLast7Days,
                      selected: range == TransactionsDateRange.last7Days,
                      onTap: () => setState(
                          () => range = TransactionsDateRange.last7Days)),
                  _Choice(
                      label: LocaleKeys.transactionsLast30Days,
                      selected: range == TransactionsDateRange.last30Days,
                      onTap: () => setState(
                          () => range = TransactionsDateRange.last30Days)),
                  _Choice(
                      label: LocaleKeys.transactionsCustomRange,
                      selected: range == TransactionsDateRange.custom,
                      icon: Icons.calendar_month_outlined,
                      onTap: _pickRange),
                ]),
                _SectionTitle(title: LocaleKeys.transactionsSort),
                Row(children: [
                  Expanded(
                      child: _Choice(
                          label: LocaleKeys.transactionsNewest,
                          selected: newestFirst,
                          icon: Icons.south,
                          onTap: () => setState(() => newestFirst = true))),
                  const SizedBox(width: 8),
                  Expanded(
                      child: _Choice(
                          label: LocaleKeys.transactionsOldest,
                          selected: !newestFirst,
                          icon: Icons.north,
                          onTap: () => setState(() => newestFirst = false)))
                ]),
              ])),
              const SizedBox(height: 14),
              SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton.icon(
                      onPressed: previewCount == 0 ? null : _apply,
                      icon: const Icon(Icons.done_all),
                      label: Text(previewCount == 0
                          ? LocaleKeys.transactionsNoMatches
                          : LocaleKeys.transactionsApplyFilters(
                              previewCount)))),
            ])));
  }

  void _toggle(String id, bool selected) =>
      setState(() => selected ? methods.add(id) : methods.remove(id));
  void _reset() => setState(() {
        status = null;
        methods.clear();
        range = TransactionsDateRange.last7Days;
        start = null;
        end = null;
        newestFirst = true;
      });
  void _apply() {
    widget.cubit.applyFilters(
        status: status,
        methods: methods,
        range: range,
        start: start,
        end: end,
        newestFirst: newestFirst);
    Navigator.pop(context);
  }

  Future<void> _pickRange() async {
    final now = DateTime.now();
    final value = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2018),
        lastDate: now,
        initialDateRange: start != null && end != null
            ? DateTimeRange(start: start!, end: end!)
            : null,
        builder: (context, child) =>
            Theme(data: Theme.of(context), child: child!));
    if (value != null && mounted) {
      setState(() {
        start = value.start;
        end = value.end;
        range = TransactionsDateRange.custom;
      });
    }
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, this.helper});
  final String title;
  final String? helper;
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 8),
      child: Row(children: [
        Expanded(child: Text(title, style: AppTextStyles(context).semiBold14)),
        if (helper != null)
          Text(helper!,
              style: AppTextStyles(context).regular11.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant))
      ]));
}

class _Choice extends StatelessWidget {
  const _Choice(
      {required this.label,
      required this.selected,
      required this.onTap,
      this.icon});
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final IconData? icon;
  @override
  Widget build(BuildContext context) => ChoiceChip(
      label: Row(mainAxisSize: MainAxisSize.min, children: [
        if (icon != null) ...[Icon(icon, size: 16), const SizedBox(width: 5)],
        Text(label)
      ]),
      selected: selected,
      onSelected: (_) => onTap());
}

class _Method extends StatelessWidget {
  const _Method(
      {required this.label,
      required this.icon,
      required this.id,
      required this.values,
      required this.onChanged,
      this.full = false});
  final String label, id;
  final IconData icon;
  final Set<String> values;
  final ValueChanged2 onChanged;
  final bool full;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return SizedBox(
        width: full ? double.infinity : (width >= 900 ? 240 : (width - 56) / 2),
        child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => onChanged(id, !values.contains(id)),
            child: Container(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 6, 6, 6),
                decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withValues(alpha: .06),
                    borderRadius: BorderRadius.circular(12)),
                child: Row(children: [
                  Icon(icon,
                      size: 18, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 8),
                  Expanded(
                      child: Text(label,
                          style: AppTextStyles(context).regular12,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis)),
                  Checkbox(
                      value: values.contains(id),
                      onChanged: (value) => onChanged(id, value ?? false),
                      visualDensity: VisualDensity.compact)
                ]))));
  }
}

typedef ValueChanged2 = void Function(String, bool);

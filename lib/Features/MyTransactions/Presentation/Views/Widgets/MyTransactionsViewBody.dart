import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/utils/locale_formatter.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Manager/my_transactions_cubit/my_transactions_cubit.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/MyTransactionListView.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/transactions_filter_sheet.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/transactions_style_mapper.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/transaction_skeleton_card.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Enums/TransactionsStatusEnum.dart';
import 'package:sintir/locale_keys.dart';

class MyTransactionsViewBody extends StatefulWidget {
  const MyTransactionsViewBody({super.key});
  @override
  State<MyTransactionsViewBody> createState() => _MyTransactionsViewBodyState();
}

class _MyTransactionsViewBodyState extends State<MyTransactionsViewBody> {
  late final ScrollController _scrollController;
  late final TextEditingController _searchController;
  String _userId = '';
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_paginate);
    _searchController = TextEditingController();
    _userId = getUserData().uid;
    WidgetsBinding.instance.addPostFrameCallback((_) => context
        .read<MyTransactionsCubit>()
        .getMyTransactions(userId: _userId, isPaginate: false));
  }

  void _paginate() {
    if (!_scrollController.hasClients ||
        _scrollController.position.extentAfter > 240) {
      return;
    }
    final state = context.read<MyTransactionsCubit>().state;
    if (state.hasMore && !state.isLoading && !state.isPaginating) {
      context
          .read<MyTransactionsCubit>()
          .getMyTransactions(userId: _userId, isPaginate: true);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<MyTransactionsCubit, MyTransactionsState>(
          builder: (context, state) {
        final theme = Theme.of(context);
        final groups = state.dayGroups;
        return Center(
            child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: RefreshIndicator(
                    onRefresh: () => context
                        .read<MyTransactionsCubit>()
                        .getMyTransactions(userId: _userId, isPaginate: false),
                    child: CustomScrollView(
                        controller: _scrollController,
                        slivers: [
                          SliverToBoxAdapter(
                              child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      20, 18, 20, 8),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Row(children: [
                                          Expanded(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                  horizontal: 8,
                                                                  vertical: 3),
                                                          decoration: BoxDecoration(
                                                              color: theme
                                                                  .colorScheme
                                                                  .primary
                                                                  .withValues(
                                                                      alpha:
                                                                          .1),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      20)),
                                                          child: Text(
                                                              LocaleKeys
                                                                  .transactionsUpdated,
                                                              style: AppTextStyles(context)
                                                                  .regular10
                                                                  .copyWith(
                                                                      color: theme
                                                                          .colorScheme
                                                                          .primary))),
                                                      const SizedBox(width: 8),
                                                      Flexible(
                                                          child: Text(
                                                              LocaleKeys
                                                                  .transactionsTitle,
                                                              style: AppTextStyles(
                                                                      context)
                                                                  .semiBold20,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis))
                                                    ]),
                                                Align(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .centerEnd,
                                                    child: Text(
                                                        LocaleKeys
                                                            .transactionsSubtitle,
                                                        style: AppTextStyles(
                                                                context)
                                                            .regular12
                                                            .copyWith(
                                                                color: theme
                                                                    .colorScheme
                                                                    .onSurfaceVariant),
                                                        textAlign:
                                                            TextAlign.end))
                                              ])),
                                        ]),
                                        const SizedBox(height: 18),
                                        Row(children: [
                                          Expanded(
                                              child: TextField(
                                                  controller: _searchController,
                                                  onChanged: context
                                                      .read<
                                                          MyTransactionsCubit>()
                                                      .search,
                                                  textInputAction:
                                                      TextInputAction.search,
                                                  decoration: InputDecoration(
                                                      hintText: LocaleKeys
                                                          .transactionsSearchHint,
                                                      prefixIcon: const Icon(
                                                          Icons.search),
                                                      isDense: true,
                                                      filled: true,
                                                      border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  14),
                                                          borderSide: BorderSide(
                                                              color: theme.dividerColor
                                                                  .withValues(
                                                                      alpha:
                                                                          .25))),
                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(14),
                                                          borderSide: BorderSide(color: theme.dividerColor.withValues(alpha: .25)))))),
                                          const SizedBox(width: 8),
                                          Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                IconButton.filledTonal(
                                                    tooltip: LocaleKeys
                                                        .transactionsFilter,
                                                    onPressed: () =>
                                                        showTransactionsFilter(
                                                            context),
                                                    icon: const Icon(
                                                        Icons.tune_rounded)),
                                                if (state.hasActiveFilters)
                                                  PositionedDirectional(
                                                      top: 5,
                                                      end: 5,
                                                      child: Container(
                                                          width: 8,
                                                          height: 8,
                                                          decoration: BoxDecoration(
                                                              color: theme
                                                                  .colorScheme
                                                                  .primary,
                                                              shape: BoxShape
                                                                  .circle)))
                                              ])
                                        ]),
                                        const SizedBox(height: 12),
                                        SizedBox(
                                            height: 42,
                                            child: ListView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                children: [
                                                  _StatusChip(
                                                      label: LocaleKeys
                                                          .transactionsAll,
                                                      count: state.count(null),
                                                      selected:
                                                          state.statusFilter ==
                                                              null,
                                                      onTap: () => context
                                                          .read<
                                                              MyTransactionsCubit>()
                                                          .setStatusFilter(
                                                              null)),
                                                  _StatusChip(
                                                      label: LocaleKeys
                                                          .transactionsSuccess,
                                                      count: state.count(
                                                          TransactionsStatus
                                                              .success),
                                                      selected:
                                                          state.statusFilter ==
                                                              TransactionsStatus
                                                                  .success,
                                                      color: TransactionsStyleMapper
                                                          .statusColor(
                                                              theme,
                                                              TransactionsStatus
                                                                  .success),
                                                      onTap: () => context
                                                          .read<
                                                              MyTransactionsCubit>()
                                                          .setStatusFilter(
                                                              TransactionsStatus
                                                                  .success)),
                                                  _StatusChip(
                                                      label: LocaleKeys
                                                          .transactionsPending,
                                                      count: state.count(
                                                          TransactionsStatus
                                                              .pending),
                                                      selected:
                                                          state.statusFilter ==
                                                              TransactionsStatus
                                                                  .pending,
                                                      color: TransactionsStyleMapper
                                                          .statusColor(
                                                              theme,
                                                              TransactionsStatus
                                                                  .pending),
                                                      onTap: () => context
                                                          .read<
                                                              MyTransactionsCubit>()
                                                          .setStatusFilter(
                                                              TransactionsStatus
                                                                  .pending)),
                                                  _StatusChip(
                                                      label: LocaleKeys
                                                          .transactionsFailed,
                                                      count: state.count(
                                                          TransactionsStatus
                                                              .failure),
                                                      selected:
                                                          state.statusFilter ==
                                                              TransactionsStatus
                                                                  .failure,
                                                      color: TransactionsStyleMapper
                                                          .statusColor(
                                                              theme,
                                                              TransactionsStatus
                                                                  .failure),
                                                      onTap: () => context
                                                          .read<
                                                              MyTransactionsCubit>()
                                                          .setStatusFilter(
                                                              TransactionsStatus
                                                                  .failure)),
                                                  _StatusChip(
                                                      label: LocaleKeys
                                                          .transactionsOther,
                                                      count: state.count(
                                                          TransactionsStatus
                                                              .other),
                                                      selected:
                                                          state.statusFilter ==
                                                              TransactionsStatus
                                                                  .other,
                                                      color: TransactionsStyleMapper
                                                          .statusColor(
                                                              theme,
                                                              TransactionsStatus
                                                                  .other),
                                                      onTap: () => context
                                                          .read<
                                                              MyTransactionsCubit>()
                                                          .setStatusFilter(
                                                              TransactionsStatus
                                                                  .other)),
                                                ])),
                                      ]))),
                          if (state.isLoading && state.transactions.isEmpty)
                            SliverList.builder(
                                itemCount: 4,
                                itemBuilder: (context, index) =>
                                    const TransactionSkeletonCard())
                          else if (state.error != null &&
                              state.transactions.isEmpty)
                            SliverFillRemaining(
                                child: Center(
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                  Text(state.error!),
                                  const SizedBox(height: 8),
                                  TextButton(
                                      onPressed: () => context
                                          .read<MyTransactionsCubit>()
                                          .getMyTransactions(
                                              userId: _userId,
                                              isPaginate: false),
                                      child:
                                          Text(LocaleKeys.transactionsRefresh))
                                ])))
                          else if (groups.isEmpty)
                            SliverFillRemaining(
                                hasScrollBody: false,
                                child: Center(
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                      Icon(Icons.receipt_long_outlined,
                                          size: 40,
                                          color: theme
                                              .colorScheme.onSurfaceVariant),
                                      const SizedBox(height: 8),
                                      Text(
                                          state.transactions.isEmpty
                                              ? LocaleKeys.transactionsNoData
                                              : LocaleKeys
                                                  .transactionsNoMatches,
                                          style: AppTextStyles(context)
                                              .semiBold14),
                                      if (state.hasActiveFilters)
                                        TextButton(
                                            onPressed: () {
                                              _searchController.clear();
                                              context
                                                  .read<MyTransactionsCubit>()
                                                  .clearFilters();
                                            },
                                            child: Text(LocaleKeys
                                                .transactionsClearFilters))
                                    ])))
                          else
                            ...groups.expand((group) => [
                                  SliverToBoxAdapter(
                                      child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(20, 18, 20, 4),
                                          child: Row(children: [
                                            Expanded(
                                                child: Text(
                                                    _groupTitle(
                                                        context, group.date),
                                                    style:
                                                        AppTextStyles(context)
                                                            .semiBold14)),
                                            Text(
                                                LocaleKeys
                                                    .transactionsCountValue(
                                                        group.transactions
                                                            .length,
                                                        Localizations.localeOf(
                                                                context)
                                                            .languageCode),
                                                style: AppTextStyles(context)
                                                    .regular11
                                                    .copyWith(
                                                        color: theme.colorScheme
                                                            .onSurfaceVariant)),
                                            if (group.total != null) ...[
                                              const SizedBox(width: 8),
                                              Directionality(
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  child: Text(
                                                      '${LocaleFormatter.number(group.total!, Localizations.localeOf(context).languageCode)} ${group.currency}',
                                                      style: AppTextStyles(
                                                              context)
                                                          .regular11
                                                          .copyWith(
                                                              color: theme
                                                                  .colorScheme
                                                                  .primary)))
                                            ]
                                          ]))),
                                  MyTransactionSliverListView(
                                      transactions: group.transactions),
                                ]),
                          if (state.isPaginating)
                            const SliverToBoxAdapter(
                                child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Center(
                                        child: CircularProgressIndicator()))),
                          const SliverToBoxAdapter(child: SizedBox(height: 28)),
                        ]))));
      });

  String _groupTitle(BuildContext context, DateTime day) {
    if (day.year == 1) {
      return LocaleKeys.transactionsOlder;
    }
    if (DateUtils.isSameDay(day, DateTime.now())) {
      return LocaleKeys.transactionsToday;
    }
    if (DateUtils.isSameDay(
        day, DateTime.now().subtract(const Duration(days: 1)))) {
      return LocaleKeys.transactionsYesterday;
    }
    return intl.DateFormat(
            'MMMM yyyy', Localizations.localeOf(context).languageCode)
        .format(day);
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip(
      {required this.label,
      required this.count,
      required this.selected,
      required this.onTap,
      this.color});
  final String label;
  final int count;
  final bool selected;
  final VoidCallback onTap;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsetsDirectional.only(end: 8),
        child: ChoiceChip(
            onSelected: (_) => onTap(),
            selected: selected,
            label: Row(mainAxisSize: MainAxisSize.min, children: [
              if (!selected && color != null)
                Container(
                    width: 7,
                    height: 7,
                    decoration:
                        BoxDecoration(color: color, shape: BoxShape.circle)),
              if (!selected && color != null) const SizedBox(width: 5),
              Text(label),
              const SizedBox(width: 6),
              Text('$count', style: AppTextStyles(context).regular10)
            ])));
  }
}

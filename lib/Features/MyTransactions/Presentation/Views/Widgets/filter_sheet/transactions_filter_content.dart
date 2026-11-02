import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Manager/my_transactions_cubit/my_transactions_cubit.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/filter_sheet/filter_apply_button.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/filter_sheet/filter_date_section.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/filter_sheet/filter_methods_section.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/filter_sheet/filter_sort_section.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/filter_sheet/filter_status_section.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Enums/TransactionsStatusEnum.dart';
import 'package:sintir/locale_keys.dart';

class TransactionsFilterContent extends StatelessWidget {
  const TransactionsFilterContent({
    super.key,
    required this.status,
    required this.methods,
    required this.range,
    required this.newestFirst,
    required this.count,
    required this.onStatus,
    required this.onMethods,
    required this.onRange,
    required this.onCustomRange,
    required this.onSort,
    required this.onReset,
    required this.onApply,
  });
  final TransactionsStatus? status;
  final Set<String> methods;
  final TransactionsDateRange range;
  final bool newestFirst;
  final int count;
  final ValueChanged<TransactionsStatus?> onStatus;
  final void Function(String, bool) onMethods;
  final ValueChanged<TransactionsDateRange> onRange;
  final VoidCallback onCustomRange, onReset, onApply;
  final ValueChanged<bool> onSort;

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 16, 20, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.filter_list_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  LocaleKeys.transactionsFilter,
                  style: AppTextStyles(context).semiBold20,
                ),
              ),
              TextButton(
                onPressed: onReset,
                child: Text(LocaleKeys.transactionsReset),
              ),
            ],
          ),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: [
                FilterStatusSection(value: status, onChanged: onStatus),
                FilterMethodsSection(values: methods, onChanged: onMethods),
                FilterDateSection(
                  range: range,
                  onChanged: onRange,
                  onCustom: onCustomRange,
                ),
                FilterSortSection(newestFirst: newestFirst, onChanged: onSort),
              ],
            ),
          ),
          const SizedBox(height: 14),
          FilterApplyButton(count: count, onPressed: onApply),
        ],
      ),
    ),
  );
}

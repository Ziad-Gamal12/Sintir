import 'package:flutter/material.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/filter_sheet/filter_choice.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/filter_sheet/filter_section_title.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Enums/TransactionsStatusEnum.dart';
import 'package:sintir/locale_keys.dart';

class FilterStatusSection extends StatelessWidget {
  const FilterStatusSection({
    super.key,
    required this.value,
    required this.onChanged,
  });
  final TransactionsStatus? value;
  final ValueChanged<TransactionsStatus?> onChanged;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      FilterSectionTitle(
        title: LocaleKeys.transactionsStatus,
        helper: LocaleKeys.transactionsSingleChoice,
      ),
      Wrap(
        spacing: 8,
        runSpacing: 4,
        children: [
          FilterChoice(
            label: LocaleKeys.transactionsAll,
            selected: value == null,
            onTap: () => onChanged(null),
          ),
          FilterChoice(
            label: LocaleKeys.transactionsSuccess,
            selected: value == TransactionsStatus.success,
            onTap: () => onChanged(TransactionsStatus.success),
          ),
          FilterChoice(
            label: LocaleKeys.transactionsFailed,
            selected: value == TransactionsStatus.failure,
            onTap: () => onChanged(TransactionsStatus.failure),
          ),
          FilterChoice(
            label: LocaleKeys.transactionsPending,
            selected: value == TransactionsStatus.pending,
            onTap: () => onChanged(TransactionsStatus.pending),
          ),
          FilterChoice(
            label: LocaleKeys.transactionsOther,
            selected: value == TransactionsStatus.other,
            onTap: () => onChanged(TransactionsStatus.other),
          ),
        ],
      ),
    ],
  );
}

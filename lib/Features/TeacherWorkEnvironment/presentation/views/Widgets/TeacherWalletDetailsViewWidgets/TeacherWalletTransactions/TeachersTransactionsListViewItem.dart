import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localingo/localingo.dart';
import 'package:sintir/Core/helper/ShowBottomSheet.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherWalletTransactionItemRequirements.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Helper/TreacherWalletTransactionItemHelper.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Listeners/TeacherWalletTransactionListener.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeacherWalletTransactionDetailsBottomSheet/TeacherWalletTransactionDetailsBottomSheet.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeacherWalletTransactions/CheckTransactionStatus.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/WithDrawTeacherBalanceCubit/WithDrawTeacherBalanceCubit.dart';
import 'package:sintir/locale_keys.dart';

import 'TransactionIssuerBadge.dart';
import 'TransactionIssuerLabel.dart';
import 'TransactionStatusBadge.dart';

class TeachersTransactionsListViewItem extends StatefulWidget {
  const TeachersTransactionsListViewItem({
    super.key,
    required this.transactionRequirements,
  });

  final TeacherWalletTransactionItemRequirements transactionRequirements;

  @override
  State<TeachersTransactionsListViewItem> createState() =>
      _TeachersTransactionsListViewItemState();
}

class _TeachersTransactionsListViewItemState
    extends State<TeachersTransactionsListViewItem> {
  late TeacherWalletTransactionListener teacherWalletTransactionListener;
  late TreacherWalletTransactionItemHelper helper;

  @override
  void initState() {
    super.initState();
    teacherWalletTransactionListener = TeacherWalletTransactionListener(
      transactionID: widget.transactionRequirements.transaction.transactionId,
    );
    helper = TreacherWalletTransactionItemHelper();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyles = AppTextStyles(context);

    return BlocConsumer<WithDrawTeacherBalanceCubit,
        WithDrawTeacherBalanceState>(
      listener: (context, state) {
        teacherWalletTransactionListener.withDrawtTeacherBalanceListener(
          context: context,
          state: state,
        );
      },
      builder: (context, state) {
        final transaction = widget.transactionRequirements.transaction;

        return InkWell(
          onTap: () {
            showCustomBottomSheet(
                child: IntrinsicHeight(
                  child: TeacherWalletTransactionDetailsBottomSheet(
                    requirements: widget.transactionRequirements,
                  ),
                ),
                context: context);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TransactionIssuerBadge(
                issuerSVG: widget.transactionRequirements.issuerPath,
                issuerColor: widget.transactionRequirements.issuerColor,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.withdrawalRequestTitle.tr(),
                                style: textStyles.bold14.copyWith(
                                  color: theme.textTheme.titleMedium?.color,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                transaction.mobileNumber ?? '',
                                style: textStyles.regular12.copyWith(
                                  color: theme.textTheme.bodySmall?.color,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.transactionRequirements.amountLabel,
                              style: textStyles.bold16.copyWith(
                                color: theme.textTheme.titleLarge?.color,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                TransactionStatusBadge(
                                  label: widget
                                      .transactionRequirements.statusLabel,
                                  color: widget
                                      .transactionRequirements.statusColor,
                                ),
                                const SizedBox(width: 8),
                                CheckTransactionStatus(
                                    color: widget
                                        .transactionRequirements.statusColor,
                                    teacherId: widget
                                        .transactionRequirements.teacherId,
                                    transaction: transaction)
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TransactionIssuerLabel(
                          issuer: widget.transactionRequirements.issuerLabel,
                          issuerColor:
                              widget.transactionRequirements.issuerColor,
                        ),
                        Text(
                          widget.transactionRequirements.dateLabel(context),
                          style: textStyles.regular11.copyWith(
                            color: theme.textTheme.bodySmall?.color,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherWalletTransactionItemRequirements.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeacherWalletTransactionDetailsBottomSheet/TransactionId.dart';
import 'package:sintir/locale_keys.dart';

import 'TransactionDetailRow.dart';

class TransactionDetailsList extends StatelessWidget {
  const TransactionDetailsList({super.key, required this.requirements});

  final TeacherWalletTransactionItemRequirements requirements;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionDetailRow(
          label: LocaleKeys.paymentMethodLabel,
          value: requirements.paymentMethodLabel,
        ),
        TransactionDetailRow(
          label: LocaleKeys.phoneNumberLabel,
          value: requirements.mobileNumber,
        ),
        TransactionDetailRow(
          label: LocaleKeys.entityLabel,
          value: requirements.issuerBrandName,
        ),
        TransactionDetailRow(
          label: LocaleKeys.transactionDateLabel,
          value: requirements.dateLabel(context),
        ),
        TransactionId(
          transactionId: requirements.transactionId,
        ),
      ],
    );
  }
}

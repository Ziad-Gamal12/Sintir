import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherWalletTransactionItemRequirements.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeacherWalletTransactionDetailsBottomSheet/TransactionDetailsCloseButton.dart.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeacherWalletTransactionDetailsBottomSheet/TransactionDetailsList.dart.dart';

import 'TransactionAmountSummaryCard.dart';
import 'TransactionDetailsSheetHandle.dart';
import 'TransactionDetailsSheetHeader.dart';

class TeacherWalletTransactionDetailsBottomSheet extends StatelessWidget {
  const TeacherWalletTransactionDetailsBottomSheet({
    super.key,
    required this.requirements,
  });

  final TeacherWalletTransactionItemRequirements requirements;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TransactionDetailsSheetHandle(),
            const TransactionDetailsSheetHeader(),
            const SizedBox(height: 20),
            TransactionAmountSummaryCard(requirements: requirements),
            const SizedBox(height: 8),
            TransactionDetailsList(requirements: requirements),
            const SizedBox(height: 20),
            const TransactionDetailsCloseButton(),
          ],
        ),
      ),
    );
  }
}

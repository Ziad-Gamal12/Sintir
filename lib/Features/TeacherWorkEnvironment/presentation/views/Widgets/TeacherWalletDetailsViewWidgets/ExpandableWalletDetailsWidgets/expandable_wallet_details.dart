import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sintir/Core/Enums/currency_enum.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeacherWalletStatusBadgeBody.dart';

import 'wallet_detail_row.dart';
import 'wallet_details_header.dart';

class ExpandableWalletDetails extends StatefulWidget {
  const ExpandableWalletDetails({
    super.key,
    required this.wallet,
  });

  final TeacherWalletEntity wallet;

  @override
  State<ExpandableWalletDetails> createState() =>
      _ExpandableWalletDetailsState();
}

class _ExpandableWalletDetailsState extends State<ExpandableWalletDetails> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.onSurface.withValues(
            alpha: 0.08,
          ),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          WalletDetailsHeader(
            isExpanded: isExpanded,
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: colorScheme.onSurface.withValues(
              alpha: 0.06,
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child:
                isExpanded ? _buildDetails(context) : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildDetails(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    return Column(
      children: [
        WalletDetailRow.text(
          label: 'رقم المحفظة',
          value: String.fromCharCodes(
            widget.wallet.walletId.toString().codeUnits,
            0,
            8,
          ),
        ),
        WalletDetailRow.text(
          label: 'العملة',
          value: currencyFromString(widget.wallet.currency).name,
        ),
        WalletDetailRow(
          label: 'حالة المحفظة',
          value: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TeacherWalletStatusBadgeBody(
              status: widget.wallet.status,
            ),
          ),
        ),
        WalletDetailRow.text(
          label: 'تاريخ إنشاء المحفظة',
          value: DateFormat(
            'd MMMM y',
            locale,
          ).format(
            DateTime.parse(widget.wallet.createdAt),
          ),
        ),
        WalletDetailRow.text(
          label: 'آخر تحديث',
          value: DateFormat(
            'yMMMMd، h:mm a',
            locale,
          ).format(
            DateTime.parse(widget.wallet.updatedAt),
          ),
        ),
        WalletDetailRow.text(
          label: 'رقم آخر معاملة',
          value: String.fromCharCodes(
            widget.wallet.lastTransactionId?.codeUnits ??
                'لا توجد معاملات'.codeUnits,
            0,
            8,
          ),
          showDivider: false,
        ),
      ],
    );
  }
}

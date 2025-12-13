import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';

class TransactionDetails extends StatelessWidget {
  const TransactionDetails({
    super.key,
    required this.transaction,
    required this.textStyle,
  });

  final TransactionEntity transaction;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recipient: ${transaction.mobileNumber}',
          style: textStyle,
        ),
        const SizedBox(height: 4),
        Text(
          'Via: ${transaction.issuer ?? 'N/A'}',
          style: textStyle,
        ),
        const SizedBox(height: 4),
        Text(
          'Ref: ${transaction.transactionId}',
          overflow: TextOverflow.ellipsis,
          style: textStyle,
        ),
      ],
    );
  }
}

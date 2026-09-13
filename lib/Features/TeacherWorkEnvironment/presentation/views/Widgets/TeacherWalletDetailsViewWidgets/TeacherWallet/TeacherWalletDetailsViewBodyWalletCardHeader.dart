import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Helper/WalletStatus.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeacherWalletStatusBadgeBody.dart';

class TeacherWalletStatusBadge extends StatelessWidget {
  const TeacherWalletStatusBadge({
    super.key,
    required this.status,
  });
  final String? status;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: WalletStatusHelper(status: status)
              .getStatusBadgeColor()
              .withAlpha(10),
          border: Border.all(
            color: WalletStatusHelper(status: status)
                .getStatusBadgeColor()
                .withAlpha(50),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TeacherWalletStatusBadgeBody(status: status));
  }
}

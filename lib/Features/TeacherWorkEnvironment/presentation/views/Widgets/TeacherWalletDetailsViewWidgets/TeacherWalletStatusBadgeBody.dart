import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Helper/WalletStatus.dart';

class TeacherWalletStatusBadgeBody extends StatelessWidget {
  const TeacherWalletStatusBadgeBody({
    super.key,
    required this.status,
  });

  final String? status;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          Icons.circle,
          color: WalletStatusHelper(status: status).getStatusBadgeColor(),
          size: 8,
        ),
        SizedBox(
          width: 6,
        ),
        Text(WalletStatusHelper(status: status).getStatusBadgeTitle(),
            style: AppTextStyles(context).semiBold12.copyWith(
                  color:
                      WalletStatusHelper(status: status).getStatusBadgeColor(),
                )),
      ],
    );
  }
}

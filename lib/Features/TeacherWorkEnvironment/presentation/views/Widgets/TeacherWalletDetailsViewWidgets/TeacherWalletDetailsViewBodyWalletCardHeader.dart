import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class TeacherWalletDetailsViewBodyWalletCardHeader extends StatelessWidget {
  const TeacherWalletDetailsViewBodyWalletCardHeader({
    super.key,
    required this.status,
  });
  final String status;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("المحفظة", style: AppTextStyles(context).bold20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          decoration: BoxDecoration(
            color: getStatusBadgeColor(status),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(getStatusBadgeTitle(status),
              style: AppTextStyles(context).regular16),
        )
      ],
    );
  }

  Color getStatusBadgeColor(String status) {
    if (status == BackendEndpoints.walletActive) {
      return Colors.green;
    } else if (status == BackendEndpoints.walletClosed) {
      return Colors.red;
    } else {
      return Colors.yellow;
    }
  }

  String getStatusBadgeTitle(String status) {
    if (status == BackendEndpoints.walletActive) {
      return "مفعلة";
    } else if (status == BackendEndpoints.walletClosed) {
      return "مغلقة";
    } else {
      return "معلقة";
    }
  }
}

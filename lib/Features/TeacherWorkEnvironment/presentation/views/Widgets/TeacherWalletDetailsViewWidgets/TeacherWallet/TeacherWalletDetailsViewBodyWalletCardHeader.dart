import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

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
          color: getStatusBadgeColor(status).withAlpha(10),
          border: Border.all(
            color: getStatusBadgeColor(status).withAlpha(50),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              Icons.circle,
              color: getStatusBadgeColor(status),
              size: 8,
            ),
            SizedBox(
              width: 6,
            ),
            Text(getStatusBadgeTitle(status),
                style: AppTextStyles(context).semiBold12.copyWith(
                      color: getStatusBadgeColor(status),
                    )),
          ],
        ));
  }

  Color getStatusBadgeColor(String? status) {
    if (status == BackendEndpoints.walletActive) {
      return Colors.green;
    } else if (status == BackendEndpoints.walletClosed) {
      return Colors.red;
    } else {
      return Colors.yellow;
    }
  }

  String getStatusBadgeTitle(String? status) {
    if (status == BackendEndpoints.walletActive) {
      return LocaleKeys.active;
    } else if (status == BackendEndpoints.walletClosed) {
      return LocaleKeys.walletNotActive;
    } else {
      return LocaleKeys.pending;
    }
  }
}

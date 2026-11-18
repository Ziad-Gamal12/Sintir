// ignore_for_file: file_names

import 'package:sintir/Core/utils/Backend_EndPoints.dart';

/// Normalized wallet status.
///
/// Only an explicit "active" allows withdrawals. "closed", missing and
/// unrecognized values all map to [inactive], so money never moves because
/// of a typo or an unexpected backend value.
enum TeacherWalletStatus {
  active,
  suspended,
  inactive;

  static TeacherWalletStatus fromRaw(String? raw) {
    switch (raw?.trim().toLowerCase()) {
      case BackendEndpoints.walletActive:
        return TeacherWalletStatus.active;
      case BackendEndpoints.walletSuspended:
        return TeacherWalletStatus.suspended;
      default:
        return TeacherWalletStatus.inactive;
    }
  }

  bool get canWithdraw => this == TeacherWalletStatus.active;
}

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/locale_keys.dart';

class WalletStatusHelper {
  final String? status;

  WalletStatusHelper({required this.status});
  Color getStatusBadgeColor() {
    if (status == BackendEndpoints.walletActive) {
      return Colors.green;
    } else if (status == BackendEndpoints.walletClosed) {
      return Colors.red;
    } else {
      return Colors.yellow;
    }
  }

  String getStatusBadgeTitle() {
    if (status == BackendEndpoints.walletActive) {
      return LocaleKeys.active;
    } else if (status == BackendEndpoints.walletClosed) {
      return LocaleKeys.walletNotActive;
    } else {
      return LocaleKeys.pending;
    }
  }
}

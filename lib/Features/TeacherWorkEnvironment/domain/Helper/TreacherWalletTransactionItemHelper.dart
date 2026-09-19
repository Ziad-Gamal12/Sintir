import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localingo/localingo.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Enums/TeacherWalletTransactionIssuer.dart';
import 'package:sintir/locale_keys.dart';

class TreacherWalletTransactionItemHelper {
  TreacherWalletTransactionItemHelper();

  Color getStatusColor({required String? status}) {
    final lowerStatus = status?.toLowerCase();
    if (lowerStatus == 'success' || lowerStatus == 'completed') {
      return Colors.green.shade600;
    } else if (lowerStatus == 'failed' || lowerStatus == 'rejected') {
      return Colors.red.shade600;
    }
    return Colors.orange.shade600;
  }

  IconData getStatusIcon({required String? status}) {
    final lowerStatus = status?.toLowerCase();
    if (lowerStatus == 'success' || lowerStatus == 'completed') {
      return Icons.check_circle_outline;
    } else if (lowerStatus == 'failed' || lowerStatus == 'rejected') {
      return Icons.cancel_outlined;
    }
    return Icons.pending_outlined;
  }

  String getStatusLabel({required String? status}) {
    final lowerStatus = status?.toLowerCase();
    if (lowerStatus == 'success' || lowerStatus == 'completed') {
      return LocaleKeys.transactionStatusCompleted.tr();
    } else if (lowerStatus == 'failed' || lowerStatus == 'rejected') {
      return LocaleKeys.transactionStatusRejected.tr();
    } else if (lowerStatus == 'pending' || lowerStatus == 'processing') {
      return LocaleKeys.transactionStatusPending.tr();
    }
    return status ?? '';
  }

  String getIssuerSVGPath({required String? issuer}) {
    final lowerIssuer = issuer?.toLowerCase();
    if (lowerIssuer == TeacherWalletTransactionIssuer.orange.name) {
      return Assets.assetsIconsSVGIconsOrangeLogo;
    } else if (lowerIssuer == TeacherWalletTransactionIssuer.vodafone.name) {
      return Assets.assetsIconsSVGIconsVodafoneLogo;
    } else if (lowerIssuer == TeacherWalletTransactionIssuer.etisalat.name) {
      return Assets.assetsIconsSVGIconsEtisalatLogo;
    } else if (lowerIssuer == TeacherWalletTransactionIssuer.we.name) {
      return Assets.assetsIconsSVGIconsWePayLogo;
    }
    return Assets.assetsIconsSVGIconsUnknown;
  }

  Color getIssuerColor({required String? issuer}) {
    final lowerIssuer = issuer?.toLowerCase();
    if (lowerIssuer == TeacherWalletTransactionIssuer.orange.name) {
      return const Color(0xffFF7900);
    } else if (lowerIssuer == TeacherWalletTransactionIssuer.vodafone.name) {
      return const Color(0xffE60000);
    } else if (lowerIssuer == TeacherWalletTransactionIssuer.etisalat.name) {
      return const Color(0xff719E19);
    } else if (lowerIssuer == TeacherWalletTransactionIssuer.we.name) {
      return const Color(0xff5C2D91);
    }
    return Colors.grey.shade600;
  }

  String getIssuerLabel({required String? issuer}) {
    final lowerIssuer = issuer?.toLowerCase();
    if (lowerIssuer == TeacherWalletTransactionIssuer.orange.name) {
      return LocaleKeys.issuerOrangeCash.tr();
    } else if (lowerIssuer == TeacherWalletTransactionIssuer.vodafone.name) {
      return LocaleKeys.issuerVodafoneCash.tr();
    } else if (lowerIssuer == TeacherWalletTransactionIssuer.etisalat.name) {
      return LocaleKeys.issuerEtisalatCash.tr();
    } else if (lowerIssuer == TeacherWalletTransactionIssuer.we.name) {
      return LocaleKeys.issuerWePay.tr();
    }
    return LocaleKeys.issuerUnknown.tr();
  }

  String formatAmount({required double? amount}) {
    return NumberFormat('#,##0.00').format(amount ?? 0);
  }

  String getCurrencyLabel({required String? currency}) {
    if (currency?.toUpperCase() == 'EGP') {
      return LocaleKeys.currencyEGP.tr();
    }
    return currency ?? '';
  }

  String formatDate(BuildContext context, {required DateTime? createdAt}) {
    String locale = Localizations.localeOf(context).languageCode;
    if (createdAt != null) {
      final date = createdAt;

      final datePart = DateFormat('d MMMM yyyy', locale).format(date);
      final timePart = DateFormat('hh:mm a', locale).format(date);
      return '$datePart  ·  $timePart';
    }
    return "";
  }

  String getIssuerBrandName({required String? issuer}) {
    final lowerIssuer = issuer?.toLowerCase();
    if (lowerIssuer == TeacherWalletTransactionIssuer.orange.name) {
      return 'Orange Cash';
    } else if (lowerIssuer == TeacherWalletTransactionIssuer.vodafone.name) {
      return 'Vodafone Cash';
    } else if (lowerIssuer == TeacherWalletTransactionIssuer.etisalat.name) {
      return 'Etisalat Cash';
    } else if (lowerIssuer == TeacherWalletTransactionIssuer.we.name) {
      return 'WE Pay';
    }
    return 'Unknown';
  }

  String getReconciliationStatusLabel({required bool? isReconciled}) {
    return isReconciled == true
        ? LocaleKeys.reconciliationStatusDone
        : LocaleKeys.reconciliationStatusPending;
  }
}

import 'package:flutter/material.dart';
import 'package:sintir/Core/helper/GridHelper.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/CustomTeacherWalletDetailsItem.dart';

class CustomTeacherWalletDetailsGridView extends StatelessWidget {
  const CustomTeacherWalletDetailsGridView(
      {super.key, required this.teacherWalletEntity});
  final TeacherWalletEntity teacherWalletEntity;
  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:
            GridHelper.getCrossAxisCount(MediaQuery.of(context).size.width),
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 3 / 2,
      ),
      children: [
        CustomTeacherWalletDetailsItem(
            icon: getCardStatusIcon(teacherWalletEntity.status),
            title: getCardStatusTitle(teacherWalletEntity.status),
            subtitle: "حالة المحفظة"),
        CustomTeacherWalletDetailsItem(
            icon: Icons.account_balance_wallet_outlined,
            title: teacherWalletEntity.totalEarned.toStringAsFixed(2),
            subtitle: "الرصيد الكلي"),
        CustomTeacherWalletDetailsItem(
            icon: Icons.account_balance_wallet_outlined,
            title: teacherWalletEntity.balance.toStringAsFixed(2),
            subtitle: "رصيد المحفظة"),
        CustomTeacherWalletDetailsItem(
            icon: Icons.pending_actions_rounded,
            title: teacherWalletEntity.payoutPending.toStringAsFixed(2),
            subtitle: "الرصيد المعلق"),
      ],
    );
  }

  IconData getCardStatusIcon(String status) {
    if (status == BackendEndpoints.walletActive) {
      return Icons.check_circle;
    } else if (status == BackendEndpoints.walletClosed) {
      return Icons.close;
    } else {
      return Icons.pending_actions_rounded;
    }
  }

  String getCardStatusTitle(String status) {
    if (status == BackendEndpoints.walletActive) {
      return "نشطة";
    } else if (status == BackendEndpoints.walletClosed) {
      return "مغلقة";
    } else {
      return "معلقة";
    }
  }
}

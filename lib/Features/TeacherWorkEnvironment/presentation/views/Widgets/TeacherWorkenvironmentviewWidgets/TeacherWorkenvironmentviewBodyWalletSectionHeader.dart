import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/TeacherWalletDetailsView.dart';
import 'package:sintir/locale_keys.dart';

class TeacherWorkenvironmentviewBodyWalletSectionHeader
    extends StatelessWidget {
  const TeacherWorkenvironmentviewBodyWalletSectionHeader(
      {super.key, required this.status});
  final String status;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.circle,
          color: statusBadgeColor(status),
          size: 20,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          LocaleKeys.wallet,
          style: AppTextStyles(context).bold20.copyWith(color: Colors.black),
        ),
        const Spacer(),
        InkWell(
            onTap: () {
              GoRouter.of(context).push(TeacherWalletDetailsView.routeName);
            },
            child: Text(LocaleKeys.viewDetails,
                style: AppTextStyles(context).regular16)),
      ],
    );
  }

  Color statusBadgeColor(String status) {
    if (status == BackendEndpoints.walletActive) {
      return Colors.green;
    } else if (status == BackendEndpoints.walletClosed) {
      return Colors.red;
    } else {
      return Colors.yellow;
    }
  }
}

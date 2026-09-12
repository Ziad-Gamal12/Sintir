import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/TeacherWalletDetailsView.dart';
import 'package:sintir/locale_keys.dart';

class TeacherWorkenvironmentviewBodyWalletSectionHeader
    extends StatelessWidget {
  const TeacherWorkenvironmentviewBodyWalletSectionHeader({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          width: 10,
        ),
        Text(
          LocaleKeys.wallet,
          style: AppTextStyles(context).bold20,
        ),
        const Spacer(),
        InkWell(
            onTap: () {
              GoRouter.of(context).push(
                TeacherWalletDetailsView.routeName,
              );
            },
            child: Text(LocaleKeys.viewDetails,
                style: AppTextStyles(context).regular16)),
      ],
    );
  }
}

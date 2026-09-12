import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeacherWallet/TeacherWalletCardIcon.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeacherWallet/TeacherWalletDetailsViewBodyWalletCardHeader.dart';

class CustomTeacherCardHeader extends StatelessWidget {
  const CustomTeacherCardHeader({
    super.key,
    required this.wallet,
  });

  final TeacherWalletEntity? wallet;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TeacherWalletCardIcon(),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "محفظة أكاديمية",
                style: AppTextStyles(context).bold16,
              ),
              Text(
                "سنتير باي • تسوية مباشرة",
                style: AppTextStyles(context)
                    .regular12
                    .copyWith(color: Color(0xff64748B)),
              ),
            ],
          ),
        ),
        TeacherWalletStatusBadge(
          status: wallet?.status,
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomCheckBox.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/PayOutBalanceWidgets/TermsAndConditions/PayoutTermsAndConditionsView.dart';
import 'package:sintir/constant.dart';

class PayOutBalanceBodyConditionsRow extends StatelessWidget {
  const PayOutBalanceBodyConditionsRow({super.key, required this.onChanged});
  final ValueChanged<bool> onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Customcheckbox(onChanged: (val) {
          onChanged(val);
        }),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: InkWell(
          onTap: () {
            GoRouter.of(context).push(PayoutTermsAndConditionsView.routeName);
          },
          child: Text.rich(TextSpan(
            text: "يجب الموافقة على ",
            style: AppTextStyles(context).regular16,
            children: [
              TextSpan(
                text: "الشروط والاحكام",
                style: AppTextStyles(context)
                    .semiBold16
                    .copyWith(color: KSecondaryColor),
              ),
            ],
          )),
        ))
      ],
    );
  }
}

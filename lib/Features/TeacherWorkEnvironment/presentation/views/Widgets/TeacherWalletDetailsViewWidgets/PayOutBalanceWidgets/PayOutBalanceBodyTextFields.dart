import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/locale_keys.dart';

class PayOutBalanceBodyTextFields extends StatelessWidget {
  const PayOutBalanceBodyTextFields({
    super.key,
    required this.phoneController,
    required this.amountController,
  });

  final TextEditingController phoneController;
  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: CustomTextField(
            hintText: LocaleKeys.walletNumberHint,
            controller: phoneController,
            prefixIcon: Icons.wallet,
            obscureText: false,
            validator: (value) {
              if (value!.isEmpty) {
                return LocaleKeys.enterWalletNumber;
              } else if (value.length != 11) {
                return LocaleKeys.enterValidWalletNumber;
              }
              return null;
            },
            textInputType: TextInputType.phone,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: CustomTextField(
            hintText: LocaleKeys.amountHint,
            controller: amountController,
            obscureText: false,
            prefixIcon: Icons.attach_money,
            validator: (value) {
              if (value!.isEmpty) {
                return LocaleKeys.enterAmount;
              }
              return null;
            },
            textInputType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}

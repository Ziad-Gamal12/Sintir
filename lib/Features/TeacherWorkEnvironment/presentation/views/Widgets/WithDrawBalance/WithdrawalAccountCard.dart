import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/locale_keys.dart';

import 'WithdrawalSurfaceCard.dart';

class WithdrawalAccountCard extends StatelessWidget {
  const WithdrawalAccountCard({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyles(context);
    return WithdrawalSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(LocaleKeys.withdrawalRecipientNumber, style: styles.bold16),
          const SizedBox(height: 10),
          CustomTextField(
            controller: controller,
            hintText: LocaleKeys.withdrawalRecipientNumber,
            prefixIcon: Icons.dialpad_outlined,
            obscureText: false,
            textInputType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(11),
            ],
            validator: (value) {
              final walletNumber = value?.trim() ?? '';
              if (walletNumber.isEmpty || walletNumber.length != 11) {
                return LocaleKeys.withdrawalInvalidRecipientNumber;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';

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
            hintText: "رقم المحفظه",
            controller: phoneController,
            prefixIcon: Icons.phone,
            obscureText: false,
            validator: (value) {
              if (value!.isEmpty) {
                return "ادخل رقم المحفظه";
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
            hintText: "المبلغ",
            controller: amountController,
            obscureText: false,
            prefixIcon: Icons.currency_bitcoin,
            validator: (value) {
              if (value!.isEmpty) {
                return "ادخل المبلغ";
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

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';

class SubscribtionViewBodyPhoneWalletTextField extends StatelessWidget {
  const SubscribtionViewBodyPhoneWalletTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "رقم المحفظه الخاصه بك",
          style: AppTextStyles.semiBold20.copyWith(color: Colors.black),
        ),
        const SizedBox(
          height: 20,
        ),
        CustomTextField(
            hintText: "رقم المحفظه الرقمية",
            obscureText: false,
            prefixIcon: FontAwesomeIcons.wallet,
            textInputType: TextInputType.phone,
            validator: (val) {
              if (val!.isEmpty) {
                return "لا يمكن ترك هذا الحقل فارغا";
              }
              return null;
            }),
        const SizedBox(
          height: 10,
        ),
        Text(
          "(01*********) الصيغة المناسبة للمحفظة الرقمية",
          style: AppTextStyles.semiBold13Auto.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}

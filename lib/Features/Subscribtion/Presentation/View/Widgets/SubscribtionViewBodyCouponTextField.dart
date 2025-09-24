import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';

class SubscribtionViewBodyCouponTextField extends StatelessWidget {
  const SubscribtionViewBodyCouponTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: "كوبون الخصم",
      obscureText: false,
      textInputType: TextInputType.text,
      prefixIcon: FontAwesomeIcons.tags,
      suffixIcon: IconButton(
        onPressed: () {
        },
        icon: const Icon(
          FontAwesomeIcons.magnifyingGlass,
          color: Colors.black,
          size: 20,
        ),
      ),
      validator: (val) {
        return null;
      },
    );
  }
}
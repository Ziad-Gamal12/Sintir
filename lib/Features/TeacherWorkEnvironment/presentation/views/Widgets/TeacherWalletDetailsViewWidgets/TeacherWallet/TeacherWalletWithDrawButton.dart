import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/constant.dart';

class TeacherWalletWithDrawButton extends StatelessWidget {
  const TeacherWalletWithDrawButton({
    super.key,
    required this.isCompact,
  });

  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: isCompact ? double.infinity : 200),
      child: Custombutton(
          text: "طلب سحب الرصيد",
          color: KMainColor,
          textColor: Colors.white,
          onPressed: () {}),
    );
  }
}

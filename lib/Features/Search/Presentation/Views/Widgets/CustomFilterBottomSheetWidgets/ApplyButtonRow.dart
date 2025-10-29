import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/constant.dart';

class ApplyButtonRow extends StatelessWidget {
  const ApplyButtonRow({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Custombutton(
                text: "فلتره",
                color: KMainColor,
                textColor: Colors.white,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

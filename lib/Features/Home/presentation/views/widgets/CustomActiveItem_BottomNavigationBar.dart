import 'package:flutter/material.dart';
import 'package:sintir/Core/helper/responsiveText.dart';
import 'package:sintir/constant.dart';

class CustomactiveitemBottomnavigationbar extends StatelessWidget {
  const CustomactiveitemBottomnavigationbar(
      {super.key, required this.icon, required this.title});
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: const EdgeInsets.all(8),
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: KMainColor, width: 1.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: KMainColor,
            size: 20,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: getresposiveTet(context: context, basesize: 14),
                fontWeight: FontWeight.w600,
                color: KMainColor),
          )
        ],
      ),
    );
  }
}

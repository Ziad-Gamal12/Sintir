import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomTeacherWalletDetailsItem extends StatelessWidget {
  const CustomTeacherWalletDetailsItem(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon});
  final String title, subtitle;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.grey, width: .5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.black, size: 30),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style:
                    AppTextStyles(context).bold20.copyWith(color: Colors.black),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                subtitle,
                style: AppTextStyles(context)
                    .regular16
                    .copyWith(color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

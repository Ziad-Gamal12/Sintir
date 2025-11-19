import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomUserInfoItem extends StatelessWidget {
  const CustomUserInfoItem(
      {super.key,
      required this.title,
      required this.value,
      required this.icon});
  final String title, value;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
          radius: 22,
          backgroundColor: Colors.grey.shade50,
          child: Icon(icon, color: Colors.black, size: 20)),
      title: Text(title,
          style:
              AppTextStyles(context).semiBold14.copyWith(color: Colors.black)),
      subtitle: Text(value,
          style:
              AppTextStyles(context).regular14.copyWith(color: Colors.black)),
    );
  }
}

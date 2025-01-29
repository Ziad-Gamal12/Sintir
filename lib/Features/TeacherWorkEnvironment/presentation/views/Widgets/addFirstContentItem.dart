import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class Addfirstcontentitem extends StatelessWidget {
  const Addfirstcontentitem(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle});
  final String image, title, subtitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      color: const Color(0xffF9FAFA),
      child: ListTile(
        leading: Image.asset(image),
        title: Text(
          title,
          style: AppTextStyles.bold16Auto.copyWith(color: Colors.black),
        ),
        subtitle: Text(
          subtitle,
          style: AppTextStyles.regular14.copyWith(color: Colors.grey),
        ),
      ),
    );
  }
}

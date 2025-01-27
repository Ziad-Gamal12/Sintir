import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:svg_flutter/svg_flutter.dart';

class Customcontactitem extends StatelessWidget {
  const Customcontactitem(
      {super.key, required this.title, required this.image});
  final String title, image;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          image,
          height: 13,
          width: 13,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(title,
            style: AppTextStyles.regular10.copyWith(color: Colors.black)),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.copy,
              color: Colors.black,
              size: 12,
            ))
      ],
    );
  }
}

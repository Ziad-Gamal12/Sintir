import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class Customteacherlocation extends StatelessWidget {
  const Customteacherlocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          FontAwesomeIcons.locationDot,
          color: Colors.black,
          size: 14,
        ),
        const SizedBox(
          width: 2,
        ),
        Text(
          "اشمون, المنوفية",
          style:
              AppTextStyles.regular10.copyWith(color: const Color(0xff818181)),
        )
      ],
    );
  }
}

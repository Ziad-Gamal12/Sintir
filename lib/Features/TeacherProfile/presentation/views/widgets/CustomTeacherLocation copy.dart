import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomteacherSubject extends StatelessWidget {
  const CustomteacherSubject({super.key, required this.subject});
  final String subject;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          FontAwesomeIcons.book,
          color: Colors.black,
          size: 14,
        ),
        const SizedBox(
          width: 2,
        ),
        Text(
          subject,
          style:
              AppTextStyles.regular10.copyWith(color: const Color(0xff818181)),
        )
      ],
    );
  }
}

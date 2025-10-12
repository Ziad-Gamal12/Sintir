import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CourseDetailsSubscribersGridviewItemPhoneNumber extends StatelessWidget {
  const CourseDetailsSubscribersGridviewItemPhoneNumber({
    super.key,
    required this.phone,
  });

  final String phone;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.phone,
          color: Colors.black,
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(
            phone == "" ? "غير محدد" : phone,
            overflow: TextOverflow.ellipsis,
            style:
                AppTextStyles(context).regular16.copyWith(color: Colors.black),
          ),
        ),
      ],
    );
  }
}

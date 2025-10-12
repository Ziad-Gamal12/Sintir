import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CourseDetailsSubscribersGridviewItemAddress extends StatelessWidget {
  const CourseDetailsSubscribersGridviewItemAddress({
    super.key,
    required this.address,
  });

  final String address;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.location_on,
          color: Colors.black,
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(
            address == "" ? "غير محدد" : address,
            overflow: TextOverflow.ellipsis,
            style:
                AppTextStyles(context).regular16.copyWith(color: Colors.black),
          ),
        ),
      ],
    );
  }
}

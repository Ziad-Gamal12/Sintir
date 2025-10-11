import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomcoursedetailsOptionitemTItleAndArrowIcon extends StatelessWidget {
  const CustomcoursedetailsOptionitemTItleAndArrowIcon({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles(context).semiBold16.copyWith(
                color: Colors.black,
              ),
        ),
        Transform.rotate(
          angle: 3.14,
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20,
          ),
        )
      ],
    );
  }
}

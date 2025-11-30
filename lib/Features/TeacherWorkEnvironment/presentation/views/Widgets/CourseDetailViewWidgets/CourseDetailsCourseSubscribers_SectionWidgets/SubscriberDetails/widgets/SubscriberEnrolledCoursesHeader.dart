import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class SubscriberEnrolledCoursesHeader extends StatelessWidget {
  const SubscriberEnrolledCoursesHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(LocaleKeys.studentSubscriptions,
            style: AppTextStyles(context).semiBold20),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

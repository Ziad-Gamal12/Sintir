import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class MyCoursesHeader extends StatelessWidget {
  const MyCoursesHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text("كورساتي",
        style: AppTextStyles.semiBold20.copyWith(color: Colors.black));
  }
}

import 'package:flutter/material.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/UserInfoSectionPersonalDetails.dart';

class CUstomPersonalDetailsSection extends StatelessWidget {
  const CUstomPersonalDetailsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 10,
        ),
        UserInfoSectionPersonalDetails(),
      ],
    );
  }
}

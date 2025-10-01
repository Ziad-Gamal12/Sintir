// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/Customonboardingpageviewentity.dart';
import 'package:sintir/Core/widgets/CustomOnboardingPageViewItem.dart';

class StudentOnboardingPageView extends StatelessWidget {
  const StudentOnboardingPageView(
      {super.key, required this.pageController, required this.onPageChanged});
  final PageController pageController;
  final ValueChanged<int> onPageChanged;
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        onPageChanged: onPageChanged,
        itemCount: CustomOnBoardingPageViewEntity.studentToList(context).length,
        controller: pageController,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CustomOnboardingPageViewItem(
            svgImage:
                CustomOnBoardingPageViewEntity.studentToList(context)[index]
                    .image,
          );
        });
  }
}

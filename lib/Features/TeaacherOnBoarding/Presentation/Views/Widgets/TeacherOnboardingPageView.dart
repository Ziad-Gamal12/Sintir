// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/Customonboardingpageviewentity.dart';
import 'package:sintir/Core/widgets/CustomOnboardingPageViewItem.dart';

class TeacherOnboardingPageView extends StatelessWidget {
  const TeacherOnboardingPageView({super.key, required this.pageController});
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        itemCount: Customonboardingpageviewentity.teacherToList(context).length,
        controller: pageController,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CustomOnboardingPageViewItem(
            entity:
                Customonboardingpageviewentity.teacherToList(context)[index],
          );
        });
  }
}

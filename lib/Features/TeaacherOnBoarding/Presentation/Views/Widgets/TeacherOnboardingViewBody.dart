// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomDotsIndicator.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Features/TeaacherOnBoarding/Presentation/Views/Widgets/TeachehrOnboardingBody_CustomButton.dart';
import 'package:sintir/Features/TeaacherOnBoarding/Presentation/Views/Widgets/TeacherOnboardingPageView.dart';

class TeacherOnboardingViewBody extends StatefulWidget {
  const TeacherOnboardingViewBody({super.key});

  @override
  State<TeacherOnboardingViewBody> createState() =>
      _TeacherOnboardingViewBodyState();
}

class _TeacherOnboardingViewBodyState extends State<TeacherOnboardingViewBody> {
  late PageController pageController;
  int currentPage = 0;
  @override
  void initState() {
    pageController = PageController();
    pageController.addListener(() {
      currentPage = pageController.page!.round();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          Expanded(
              child: TeacherOnboardingPageView(
            pageController: pageController,
          )),
          const Customsizedbox(width: 0, height: 64),
          CustomDotsIndicator(pageController: pageController),
          const Customsizedbox(width: 0, height: 30),
          TeachehrOnboardingBody_CustomButton(
              currentPage: currentPage, pageController: pageController),
        ],
      ),
    );
  }
}

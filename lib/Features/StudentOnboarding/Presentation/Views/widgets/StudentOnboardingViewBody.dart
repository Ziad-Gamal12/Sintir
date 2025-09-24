// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomDotsIndicator.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Features/StudentOnboarding/Presentation/Views/widgets/StudentOnboardingBody_CustomButton.dart';
import 'package:sintir/Features/StudentOnboarding/Presentation/Views/widgets/StudentOnboardingPageView.dart';

class StudentOnboardingViewBody extends StatefulWidget {
  const StudentOnboardingViewBody({super.key});
  @override
  State<StudentOnboardingViewBody> createState() =>
      _StudentOnboardingViewBodyState();
}

class _StudentOnboardingViewBodyState extends State<StudentOnboardingViewBody> {
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
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 2,
            child: StudentOnboardingPageView(
              pageController: pageController,
            )),
        const Spacer(),
        CustomDotsIndicator(pageController: pageController),
        const Customsizedbox(width: 0, height: 20),
        StudentOnboardingBody_CustomButton(
            currentPage: currentPage, pageController: pageController),
        const Customsizedbox(width: 0, height: 20),
      ],
    );
  }
}

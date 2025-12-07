// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/Customonboardingpageviewentity.dart';
import 'package:sintir/Features/TeaacherOnBoarding/Presentation/Views/Widgets/TeacherOnboardingInfoCard.dart';
import 'package:sintir/Features/TeaacherOnBoarding/Presentation/Views/Widgets/TeacherOnboardingPageView.dart';

class TeacherOnboardingViewBody extends StatefulWidget {
  const TeacherOnboardingViewBody({super.key});

  @override
  State<TeacherOnboardingViewBody> createState() =>
      _TeacherOnboardingViewBodyState();
}

class _TeacherOnboardingViewBodyState extends State<TeacherOnboardingViewBody> {
  late final PageController pageController;
  final ValueNotifier<int> currentPageNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    currentPageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = CustomOnBoardingPageViewEntity.teacherToList(context);

    return Column(
      children: [
        Expanded(
          flex: 3,
          child: TeacherOnboardingPageView(
            pageController: pageController,
            onPageChanged: (index) => currentPageNotifier.value = index,
          ),
        ),
        Expanded(
          flex: 2,
          child: TeacherOnboardingInfoCard(
            pages: pages,
            currentPageNotifier: currentPageNotifier,
            pageController: pageController,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sintir/constant.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TeacherOnboardingBody_CustomDotsIndicator extends StatelessWidget {
  const TeacherOnboardingBody_CustomDotsIndicator({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: pageController,
      count: 3,
      effect: const WormEffect(
          dotHeight: 9,
          dotWidth: 9,
          dotColor: Color(0xff87CEFA),
          activeDotColor: KMainColor),
    );
  }
}

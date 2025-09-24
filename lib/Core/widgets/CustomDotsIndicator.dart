// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/constant.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomDotsIndicator extends StatelessWidget {
  const CustomDotsIndicator({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: pageController,
      count: 3,
      effect: const ExpandingDotsEffect(
          dotHeight: 9,
          dotWidth: 9,
          dotColor: Color(0xff87CEFA),
          activeDotColor: KMainColor),
    );
  }
}

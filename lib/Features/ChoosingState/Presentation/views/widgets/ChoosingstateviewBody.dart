// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:sintir/Features/ChoosingState/Presentation/views/widgets/CustomPageView.dart';
import 'package:sintir/constant.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ChoosingstateviewBody extends StatelessWidget {
  ChoosingstateviewBody({super.key});
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Column(
        children: [
          Expanded(
              flex: 8,
              child: Custompageview(
                controller: pageController,
              )),
          const Expanded(flex: 1, child: SizedBox()),
          SmoothPageIndicator(
            controller: pageController,
            count: 2,
            effect: const WormEffect(
                dotHeight: 9,
                dotWidth: 9,
                dotColor: Color(0xff87CEFA),
                activeDotColor: KMainColor),
          )
        ],
      ),
    );
  }
}

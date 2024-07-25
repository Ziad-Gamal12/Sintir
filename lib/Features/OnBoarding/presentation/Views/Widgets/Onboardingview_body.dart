import 'package:flutter/material.dart';
import 'package:sintir/Features/OnBoarding/presentation/Views/Widgets/Onboarding_PageView.dart';
import 'package:sintir/Features/OnBoarding/presentation/Views/Widgets/onbBoarding_Button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboardingview_body extends StatefulWidget {
  @override
  State<Onboardingview_body> createState() => _Onboardingview_bodyState();
}

class _Onboardingview_bodyState extends State<Onboardingview_body> {
  late PageController pageController;
  int CurrentPage = 0;

  @override
  void initState() {
    pageController = PageController();
    pageController.addListener(() {
      CurrentPage = pageController.page!.round();
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    pageController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: OnboardingPageview(
        controller: pageController,
      )),
      SizedBox(height: 20),
      SmoothPageIndicator(
        controller: pageController,
        count: 4,
        axisDirection: Axis.horizontal,
        effect: ExpandingDotsEffect(
          dotColor: Color(0xff80A0D2).withOpacity(0.3),
          activeDotColor: Color(0xff80A0D2),
          dotHeight: 10,
          dotWidth: 10,
          expansionFactor: 4,
          spacing: 5,
        ),
      ),
      SizedBox(height: 15),
      onbBoarding_Button(
          CurrentPage: CurrentPage, pageController: pageController)
    ]);
  }
}

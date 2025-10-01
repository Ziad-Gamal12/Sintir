import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/Customonboardingpageviewentity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/StudentOnboarding/Presentation/Views/widgets/StudentOnboardingBody_CustomButton.dart';

class StudentOnboardingInfoCard extends StatelessWidget {
  const StudentOnboardingInfoCard({
    super.key,
    required this.pages,
    required this.currentPageNotifier,
    required this.pageController,
  });

  final List<CustomOnBoardingPageViewEntity> pages;
  final ValueNotifier<int> currentPageNotifier;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 60,
            spreadRadius: 3,
            offset: const Offset(5, 10),
          )
        ],
      ),
      child: ValueListenableBuilder<int>(
        valueListenable: currentPageNotifier,
        builder: (context, currentPage, _) {
          final page = pages[currentPage];
          return Column(
            children: [
              page.title,
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 37),
                child: Text(
                  page.description,
                  textAlign: TextAlign.justify,
                  style: AppTextStyles(context)
                      .regular13
                      .copyWith(color: const Color(0xff4E5556)),
                ),
              ),
              const Spacer(),
              StudentOnboardingButton(
                currentPageNotifier: currentPageNotifier,
                pageController: pageController,
              ),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}

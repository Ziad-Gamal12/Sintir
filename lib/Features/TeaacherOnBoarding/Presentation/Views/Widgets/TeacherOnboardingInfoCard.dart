import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/Customonboardingpageviewentity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeaacherOnBoarding/Presentation/Views/Widgets/TeacherOnboardingButton.dart';

class TeacherOnboardingInfoCard extends StatelessWidget {
  const TeacherOnboardingInfoCard({
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 30,
            spreadRadius: 3,
            offset: Offset(5, 10),
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
              const SizedBox(height: 16),
              Text(
                page.description,
                textAlign: TextAlign.justify,
                style: AppTextStyles(context).regular14,
              ),
              const Spacer(),
              TeacherOnBoardingButton(
                currentPageNotifier: currentPageNotifier,
                pageController: pageController,
              ),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}

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
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      decoration: BoxDecoration(
        color: theme.cardColor, // ← يدعم Light / Dark
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.shade300,
            blurRadius: 40,
            spreadRadius: 3,
            offset: const Offset(0, 8),
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

              // Description Text
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 37),
                child: Text(
                  page.description,
                  textAlign: TextAlign.justify,
                  style: AppTextStyles(context).regular13.copyWith(
                        color:
                            theme.textTheme.bodyMedium!.color!.withOpacity(0.8),
                      ),
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

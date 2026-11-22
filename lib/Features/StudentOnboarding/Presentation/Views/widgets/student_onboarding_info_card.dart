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
    this.isSideCard = false,
  });

  final List<CustomOnBoardingPageViewEntity> pages;
  final ValueNotifier<int> currentPageNotifier;
  final PageController pageController;

  final bool isSideCard;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSideCard ? 32 : 15,
        vertical: 30,
      ),
      decoration: BoxDecoration(
        color: theme.cardColor, // ← يدعم Light / Dark
        borderRadius: isSideCard
            ? BorderRadius.circular(28)
            : const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.grey.shade300,
            blurRadius: 40,
            spreadRadius: 3,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: ValueListenableBuilder<int>(
            valueListenable: currentPageNotifier,
            builder: (context, currentPage, _) {
              final page = pages[currentPage];

              // Description Text
              final description = Container(
                margin: EdgeInsets.symmetric(
                  horizontal: isSideCard ? 0 : 37,
                ),
                child: Text(
                  page.description,
                  textAlign: TextAlign.justify,
                  style: AppTextStyles(context).regular13.copyWith(
                        color: theme.textTheme.bodyMedium!.color!
                            .withValues(alpha: 0.8),
                      ),
                ),
              );
              final title = DefaultTextStyle.merge(
                style: AppTextStyles(context).semiBold24,
                textAlign: TextAlign.center,
                child: page.title,
              );
              final button = StudentOnboardingButton(
                currentPageNotifier: currentPageNotifier,
                pageController: pageController,
              );

              if (isSideCard) {
                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        title,
                        const SizedBox(height: 20),
                        description,
                        const SizedBox(height: 32),
                        button,
                      ],
                    ),
                  ),
                );
              }

              return Column(
                children: [
                  title,
                  const SizedBox(height: 20),
                  description,
                  const Spacer(),
                  button,
                  const SizedBox(height: 20),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

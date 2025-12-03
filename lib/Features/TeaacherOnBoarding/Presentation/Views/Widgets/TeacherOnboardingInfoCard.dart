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
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow
                .withOpacity(theme.brightness == Brightness.dark ? 0.4 : 0.15),
            blurRadius: 30,
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
              const SizedBox(height: 16),
              Text(
                page.description,
                textAlign: TextAlign.justify,
                style: AppTextStyles(context).regular14.copyWith(
                      color: colorScheme
                          .onSurface, // Text color that contrasts with the surface
                    ),
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

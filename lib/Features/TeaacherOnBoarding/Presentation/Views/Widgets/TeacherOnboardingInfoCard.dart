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
    this.isSideCard = false,
  });

  final List<CustomOnBoardingPageViewEntity> pages;
  final ValueNotifier<int> currentPageNotifier;
  final PageController pageController;

  /// true: a free-standing rounded card beside the illustration (wide layouts).
  /// false: the bottom sheet under the illustration (phones, tablets in portrait).
  final bool isSideCard;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSideCard ? 32 : 16,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: isSideCard
            ? BorderRadius.circular(28)
            : const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(
                alpha: theme.brightness == Brightness.dark ? 0.4 : 0.15),
            blurRadius: 30,
            spreadRadius: 3,
            offset: const Offset(5, 10),
          )
        ],
      ),
      child: Align(
        alignment: Alignment.topCenter,
        // Text lines stay readable when the sheet spans a tablet.
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: ValueListenableBuilder<int>(
            valueListenable: currentPageNotifier,
            builder: (context, currentPage, _) {
              final page = pages[currentPage];
              final description = Text(
                page.description,
                textAlign: TextAlign.justify,
                style: AppTextStyles(context).regular14.copyWith(
                      color: colorScheme
                          .onSurface, // Text color that contrasts with the surface
                    ),
              );
              final button = TeacherOnBoardingButton(
                currentPageNotifier: currentPageNotifier,
                pageController: pageController,
              );

              if (isSideCard) {
                // Centred, and scrollable when a phone in landscape is too short.
                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        page.title,
                        const SizedBox(height: 16),
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
                  page.title,
                  const SizedBox(height: 16),
                  description,
                  const Spacer(),
                  button,
                  const SizedBox(height: 16),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/Customonboardingpageviewentity.dart';
import 'package:sintir/Core/responsive/breakpoints.dart';
import 'package:sintir/Features/StudentOnboarding/Presentation/Views/widgets/StudentOnboardingPageView.dart';
import 'package:sintir/Features/StudentOnboarding/Presentation/Views/widgets/student_onboarding_info_card.dart';

class StudentOnboardingViewBody extends StatefulWidget {
  const StudentOnboardingViewBody({super.key});

  @override
  State<StudentOnboardingViewBody> createState() =>
      _StudentOnboardingViewBodyState();
}

class _StudentOnboardingViewBodyState extends State<StudentOnboardingViewBody> {
  late final PageController pageController;
  final ValueNotifier<int> currentPageNotifier = ValueNotifier(0);

  // Keep the PageView (and its current page) and the card alive when a
  // rotation switches between the stacked and the side-by-side layout.
  final GlobalKey _pageViewKey = GlobalKey();
  final GlobalKey _cardKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    currentPageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = CustomOnBoardingPageViewEntity.studentToList(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = Breakpoints.isWide(constraints);

        final pageView = KeyedSubtree(
          key: _pageViewKey,
          child: StudentOnboardingPageView(
            pageController: pageController,
            onPageChanged: (index) => currentPageNotifier.value = index,
          ),
        );
        final card = KeyedSubtree(
          key: _cardKey,
          child: StudentOnboardingInfoCard(
            pages: pages,
            currentPageNotifier: currentPageNotifier,
            pageController: pageController,
            isSideCard: isWide,
          ),
        );

        if (isWide) {
          // Landscape / large screens: illustration and text side by side.
          final cardWidth =
              (constraints.maxWidth * 0.42).clamp(320.0, 500.0).toDouble();
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 24,
                children: [
                  Expanded(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 620),
                        child: pageView,
                      ),
                    ),
                  ),
                  SizedBox(width: cardWidth, child: card),
                ],
              ),
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              flex: 3,
              child: Center(
                // On tablets in portrait the illustration stops growing at 560.
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: pageView,
                ),
              ),
            ),
            Expanded(flex: 2, child: card),
          ],
        );
      },
    );
  }
}

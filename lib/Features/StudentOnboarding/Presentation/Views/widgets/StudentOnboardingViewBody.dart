import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/Customonboardingpageviewentity.dart';
import 'package:sintir/Core/responsive/breakpoints.dart';
import 'package:sintir/Core/widgets/AdaptiveAuth/AuthHeader.dart';
import 'package:sintir/Core/widgets/AdaptiveAuth/OnboardingAdaptiveLayout.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/Student_Sign_In_View.dart';
import 'package:sintir/Features/StudentOnboarding/Presentation/Views/widgets/StudentOnboardingPageView.dart';
import 'package:sintir/Features/StudentOnboarding/Presentation/Views/widgets/student_onboarding_info_card.dart';
import 'package:sintir/locale_keys.dart';

class StudentOnboardingViewBody extends StatefulWidget {
  const StudentOnboardingViewBody({super.key});

  @override
  State<StudentOnboardingViewBody> createState() =>
      _StudentOnboardingViewBodyState();
}

class _StudentOnboardingViewBodyState extends State<StudentOnboardingViewBody> {
  late final PageController pageController;
  final ValueNotifier<int> currentPageNotifier = ValueNotifier(0);

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
        final isTablet =
            !isWide && constraints.maxWidth >= Breakpoints.medium;

        final pageView = KeyedSubtree(
          key: _pageViewKey,
          child: StudentOnboardingPageView(
            pageController: pageController,
            onPageChanged: (index) => currentPageNotifier.value = index,
          ),
        );

        if (isWide || isTablet) {
          return OnboardingAdaptiveLayout(
            pages: pages,
            pageView: pageView,
            currentPageNotifier: currentPageNotifier,
            pageController: pageController,
            stacked: isTablet,
            badge: AuthRoleBadge(
              label: LocaleKeys.studentRole,
              icon: Icons.school_outlined,
            ),
            onFinish: () {
              GoRouter.of(context).push(StudentSignInView.routeName);
            },
          );
        }

        final card = KeyedSubtree(
          key: _cardKey,
          child: StudentOnboardingInfoCard(
            pages: pages,
            currentPageNotifier: currentPageNotifier,
            pageController: pageController,
          ),
        );

        return Column(
          children: [
            Expanded(
              flex: 3,
              child: Center(
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

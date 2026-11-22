// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/Customonboardingpageviewentity.dart';
import 'package:sintir/Core/responsive/breakpoints.dart';
import 'package:sintir/Core/widgets/AdaptiveAuth/AuthHeader.dart';
import 'package:sintir/Core/widgets/AdaptiveAuth/OnboardingAdaptiveLayout.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/TeacherSignInView.dart';
import 'package:sintir/Features/TeaacherOnBoarding/Presentation/Views/Widgets/TeacherOnboardingInfoCard.dart';
import 'package:sintir/Features/TeaacherOnBoarding/Presentation/Views/Widgets/TeacherOnboardingPageView.dart';
import 'package:sintir/locale_keys.dart';

class TeacherOnboardingViewBody extends StatefulWidget {
  const TeacherOnboardingViewBody({super.key});

  @override
  State<TeacherOnboardingViewBody> createState() =>
      _TeacherOnboardingViewBodyState();
}

class _TeacherOnboardingViewBodyState extends State<TeacherOnboardingViewBody> {
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
    final pages = CustomOnBoardingPageViewEntity.teacherToList(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = Breakpoints.isWide(constraints);
        final isTablet =
            !isWide && constraints.maxWidth >= Breakpoints.medium;

        final pageView = KeyedSubtree(
          key: _pageViewKey,
          child: TeacherOnboardingPageView(
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
              label: LocaleKeys.teacherRole,
              icon: Icons.cast_for_education_outlined,
            ),
            onFinish: () {
              GoRouter.of(context).push(TeacherSignInView.routeName);
            },
          );
        }

        final card = KeyedSubtree(
          key: _cardKey,
          child: TeacherOnboardingInfoCard(
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

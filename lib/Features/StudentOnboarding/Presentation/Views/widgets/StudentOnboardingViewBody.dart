import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/Customonboardingpageviewentity.dart';
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

    return Column(
      children: [
        Expanded(
          flex: 3,
          child: StudentOnboardingPageView(
            pageController: pageController,
            onPageChanged: (index) => currentPageNotifier.value = index,
          ),
        ),
        Expanded(
          flex: 2,
          child: StudentOnboardingInfoCard(
            pages: pages,
            currentPageNotifier: currentPageNotifier,
            pageController: pageController,
          ),
        ),
      ],
    );
  }
}

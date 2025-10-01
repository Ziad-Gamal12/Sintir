import 'package:circular_progress_button/circular_progress_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Features/Auth/TeacherPresentation/views/TeacherSignInView.dart';
import 'package:sintir/Features/StudentOnboarding/Presentation/Views/widgets/student_onboarding_button_icon.dart';
import 'package:sintir/constant.dart';

class TeacherOnBoardingButton extends StatelessWidget {
  const TeacherOnBoardingButton({
    super.key,
    required this.currentPageNotifier,
    required this.pageController,
  });

  final ValueNotifier<int> currentPageNotifier;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
      child: ValueListenableBuilder(
          valueListenable: currentPageNotifier,
          builder: (context, currentPage, _) {
            return CircularProgressButton(
              currentStep: currentPage,
              totalSteps: 3,
              theme: ProgressButtonTheme(
                progressColor: KMainColor,
                backgroundColor: Colors.transparent.withOpacity(.1),
                strokeWidth: 5,
                size: 90,
                iconSize: 50,
                icon: Icons.arrow_forward,
                iconWidget: const StudentOnboardingButtonIcon(),
              ),
              onTap: () => pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
              ),
              onComplete: () {
                GoRouter.of(context).push(TeacherSignInView.routeName);
              },
              animationDuration: const Duration(milliseconds: 500),
            );
          }),
    );
  }
}

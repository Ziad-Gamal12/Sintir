// ignore_for_file: use_build_context_synchronously

import 'package:circular_progress_button/circular_progress_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/Student_Sign_In_View.dart';
import 'package:sintir/Features/StudentOnboarding/Presentation/Views/widgets/student_onboarding_button_icon.dart';
import 'package:sintir/constant.dart';

class StudentOnboardingButton extends StatefulWidget {
  const StudentOnboardingButton({
    super.key,
    required this.currentPageNotifier,
    required this.pageController,
  });

  final ValueNotifier<int> currentPageNotifier;
  final PageController pageController;

  @override
  State<StudentOnboardingButton> createState() =>
      _StudentOnboardingButtonState();
}

class _StudentOnboardingButtonState extends State<StudentOnboardingButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
      child: ValueListenableBuilder(
          valueListenable: widget.currentPageNotifier,
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
              onTap: () {
                if (currentPage == 2) {
                  Future.delayed(const Duration(milliseconds: 500))
                      .then((value) {
                    if (!mounted) return;
                    GoRouter.of(context).push(StudentSignInView.routeName);
                  });
                } else {
                  widget.pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  );
                }
              },
              onComplete: () {
                GoRouter.of(context).push(StudentSignInView.routeName);
              },
              animationDuration: const Duration(milliseconds: 500),
            );
          }),
    );
  }
}

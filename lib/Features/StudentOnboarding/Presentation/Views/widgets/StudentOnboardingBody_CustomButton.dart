// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Auth/StudentPresentation/views/Student_Sign_In_View.dart';
import 'package:sintir/constant.dart';

class StudentOnboardingBody_CustomButton extends StatelessWidget {
  const StudentOnboardingBody_CustomButton({
    super.key,
    required this.currentPage,
    required this.pageController,
  });

  final int currentPage;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
      child: Custombutton(
          text: currentPage == 2 ? "ابدأ الان" : "التالي",
          color: KMainColor,
          textColor: Colors.white,
          onPressed: () {
            if (currentPage == 2) {
              GoRouter.of(context).push(StudentSignInView.routeName);
            } else {
              pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn);
            }
          }),
    );
  }
}

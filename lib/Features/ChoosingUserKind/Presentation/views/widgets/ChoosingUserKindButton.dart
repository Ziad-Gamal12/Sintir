import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/StudentOnboarding/Presentation/Views/StudentOnboardingView.dart';
import 'package:sintir/Features/TeaacherOnBoarding/Presentation/Views/TeacherOnboardingView.dart';
import 'package:sintir/constant.dart';

class ChoosingUserKindButton extends StatelessWidget {
  const ChoosingUserKindButton({
    super.key,
    required this.currentPage,
  });

  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Custombutton(
        text: "أبدا ك${currentPage == 0 ? "طالب" : "معلم"}",
        color: KMainColor,
        textColor: Colors.white,
        onPressed: () {
          if (currentPage == 0) {
            GoRouter.of(context).push(StudentOnboardingView.routeName);
          } else {
            GoRouter.of(context).push(TeacherOnboardingView.routeName);
          }
        });
  }
}

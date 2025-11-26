import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/StudentOnboarding/Presentation/Views/StudentOnboardingView.dart';
import 'package:sintir/Features/TeaacherOnBoarding/Presentation/Views/TeacherOnboardingView.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class ChoosingUserKindButton extends StatelessWidget {
  const ChoosingUserKindButton({
    super.key,
    required this.currentPage,
  });

  final int currentPage;

  @override
  Widget build(BuildContext context) {
    final isStudent = currentPage == 0;
    final buttonText =
        "${LocaleKeys.startAsButton} ${isStudent ? LocaleKeys.studentRole : LocaleKeys.teacherRole}";

    return Custombutton(
      text: buttonText,
      color: KMainColor,
      textColor: Colors.white,
      onPressed: () {
        final route = isStudent
            ? StudentOnboardingView.routeName
            : TeacherOnboardingView.routeName;

        GoRouter.of(context).push(route);
      },
    );
  }
}

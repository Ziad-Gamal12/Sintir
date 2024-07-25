import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Utils/AppRoute.dart';
import 'package:sintir/Core/Utils/shared_Preference_Keys.dart';
import 'package:sintir/Core/Utils/textStyles.dart';
import 'package:sintir/Core/Widgets/Custom_Button.dart';
import 'package:sintir/Core/services/Shared_preferences.dart';
import 'package:sintir/constant.dart';

class onbBoarding_Button extends StatelessWidget {
  const onbBoarding_Button({
    super.key,
    required this.CurrentPage,
    required this.pageController,
  });

  final int CurrentPage;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: KHorizontalPadding, vertical: 10),
        child: CustomButton(
            borderradius: BorderRadius.circular(10),
            widget: Text(
              CurrentPage == 3 ? "ابدأ الآن" : "التالي",
              style: textStyles.textstyle16
                  .copyWith(fontWeight: FontWeight.w700, color: Colors.white),
            ),
            onTap: () {
              if (CurrentPage == 3) {
                shared_preferences_Services.boolSetter(
                    key: SharedPreferenceKeys.OnboardingSeen, value: true);
                GoRouter.of(context).pushReplacement(Approute.StudentSignin);
              } else {
                pageController.nextPage(
                    duration: Duration(milliseconds: 300), curve: Curves.ease);
              }
            }));
  }
}

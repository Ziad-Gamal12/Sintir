import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Utils/AppRoute.dart';
import 'package:sintir/Core/Utils/shared_Preference_Keys.dart';
import 'package:sintir/Core/Widgets/Custom_AppIogo.dart';
import 'package:sintir/Core/services/Shared_preferences.dart';
import 'package:sintir/Features/Splash/presentation/Views/Widgets/SplashView_Body_BottomLeft_Icon.dart';
import 'package:sintir/Features/Splash/presentation/Views/Widgets/SplashView_Body_TopRight_Icon.dart';

class Splashview_body extends StatefulWidget {
  @override
  State<Splashview_body> createState() => _Splashview_bodyState();
}

class _Splashview_bodyState extends State<Splashview_body> {
  @override
  void initState() {
    autoNavigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SplashView_Body_TopRight_Icon(),
        Custom_AppLogo(
          height: 150,
          width: 150,
        ),
        SplashView_Body_BottomLeft_Icon(),
      ],
    );
  }

  autoNavigate() {
    bool isonBoardingSeen = shared_preferences_Services.boolgetter(
        key: SharedPreferenceKeys.OnboardingSeen);
    Future.delayed(Duration(seconds: 3), () {
      if (isonBoardingSeen == true) {
        GoRouter.of(context).pushReplacement(Approute.StudentSignin);
      } else {
        GoRouter.of(context).pushReplacement(Approute.Onboarding);
      }
    });
  }
}

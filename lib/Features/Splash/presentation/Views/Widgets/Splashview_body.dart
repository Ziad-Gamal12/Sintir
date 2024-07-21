import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Utils/AppRoute.dart';
import 'package:sintir/Core/Widgets/Custom_AppIcon.dart';
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
        Custom_AppIcon(
          height: 150,
          width: 150,
        ),
        SplashView_Body_BottomLeft_Icon(),
      ],
    );
  }

  autoNavigate() {
    Future.delayed(Duration(seconds: 3), () {
      GoRouter.of(
        context,
      ).pushReplacement(Approute.Onboarding);
    });
  }
}

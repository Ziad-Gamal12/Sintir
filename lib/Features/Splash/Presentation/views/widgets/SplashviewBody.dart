// ignore_for_file: file_names, non_constant_identifier_names, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/services/FirebaseAuth_Service.dart';
import 'package:sintir/Features/ChoosingUserKind/Presentation/views/ChoosingUserKindView.dart';
import 'package:sintir/Features/Home/presentation/views/HomeView.dart';
import 'package:sintir/Features/Splash/Presentation/views/widgets/CenterTextAndLogo.dart';
import 'package:sintir/Features/Splash/Presentation/views/widgets/bottomClipperWidget.dart';

class SplashviewBody extends StatefulWidget {
  const SplashviewBody({super.key});
  @override
  State<SplashviewBody> createState() => _SplashviewBodyState();
}

class _SplashviewBodyState extends State<SplashviewBody> {
  @override
  void initState() {
    authNavigation(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade800, Colors.blue.shade400],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: const CenterTextAndLogo(),
        ),
        const BottomClipperWidget(),
      ],
    );
  }

  Future<void> authNavigation(BuildContext context) async {
    bool isLoggedin = await firebaseAuthService().isLoggedIn();
    await Future.delayed(const Duration(seconds: 3), () {
      if (isLoggedin == true) {
        GoRouter.of(context).go(Homeview.routeName);
      } else {
        GoRouter.of(context).go(ChoosingUserKindView.routeName);
      }
    });
  }
}

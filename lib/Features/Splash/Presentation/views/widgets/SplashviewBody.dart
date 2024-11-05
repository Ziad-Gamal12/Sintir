// ignore_for_file: file_names, non_constant_identifier_names, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/services/FirebaseAuth_Service.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Features/ChoosingState/Presentation/views/ChoosingStateView.dart';
import 'package:sintir/Features/Home/presentation/views/HomeView.dart';
import 'package:sintir/Features/Splash/Presentation/views/widgets/SplashViewBodyBottomText.dart';
import 'package:svg_flutter/svg.dart';

class SplashviewBody extends StatefulWidget {
  const SplashviewBody({super.key});

  @override
  State<SplashviewBody> createState() => _SplashviewBodyState();
}

class _SplashviewBodyState extends State<SplashviewBody> {
  firebaseAuthService auth = firebaseAuthService();
  @override
  void initState() {
    AuthNavigation(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(),
        SvgPicture.asset(Assets.assetsImagesSintirLogo),
        const Spacer(),
        const SplashViewBodyBottomText(),
        const SizedBox(
          height: 27,
        ),
      ],
    );
  }

  Future<void> AuthNavigation(BuildContext context) async {
    bool isLoggedin = await auth.isLoggedIn();
    await Future.delayed(const Duration(seconds: 3), () {
      if (isLoggedin == true) {
        GoRouter.of(context).pushReplacement(Homeview.routeName);
      } else {
        GoRouter.of(context).pushReplacement(Choosingstateview.routeName);
      }
    });
  }
}

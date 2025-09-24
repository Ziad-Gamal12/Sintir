// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Features/Splash/Presentation/views/widgets/SplashviewBody.dart';

class Splashview extends StatelessWidget {
  const Splashview({super.key});
  static const String routeName = "/";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashviewBody(),
    );
  }
}

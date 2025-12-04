import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/AboutUsViewWidgets/AboutUsViewBody.dart';
import 'package:sintir/locale_keys.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});
  static String routeName = "/AboutUsView";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBartitle: LocaleKeys.profileAbout),
      body: const AboutUsViewBody(),
    );
  }
}

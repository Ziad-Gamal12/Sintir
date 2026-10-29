import 'package:flutter/material.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/AboutUsViewWidgets/AboutUSDescription.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/AboutUsViewWidgets/AboutUsFadeSlide.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/AboutUsViewWidgets/AboutUsHeader.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/AboutUsViewWidgets/AboutUsHighlights.dart';

class AboutUsViewBody extends StatelessWidget {
  const AboutUsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AboutUsFadeSlide(child: AboutUsHeader()),
                SizedBox(height: 20),
                AboutUsFadeSlide(
                  delay: Duration(milliseconds: 120),
                  child: AboutUSDescription(),
                ),
                SizedBox(height: 16),
                AboutUsFadeSlide(
                  delay: Duration(milliseconds: 240),
                  child: AboutUsHighlights(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

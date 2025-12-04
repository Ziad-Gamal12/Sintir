import 'package:flutter/material.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/AboutUsViewWidgets/AboutUSDescription.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/AboutUsViewWidgets/AboutUsIcon.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/AboutUsViewWidgets/AboutUsTitle.dart';

class AboutUsViewBody extends StatelessWidget {
  const AboutUsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 650),
          tween: Tween(begin: 0.92, end: 1),
          curve: Curves.easeOutCubic,
          builder: (context, scale, _) => Transform.scale(
            scale: scale,
            child: _buildPremiumCard(context, isDark),
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumCard(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),

        border: Border.all(
          width: 1.4,
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.black.withOpacity(0.05),
        ),

        gradient: LinearGradient(
          colors: isDark
              ? [
                  const Color(0xff1A1A1A),
                  const Color(0xff0f0f0f),
                ]
              : [
                  Colors.white.withOpacity(0.95),
                  Colors.grey.shade100,
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        // ----------- SOFT SHADOW -----------
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.45)
                : Colors.grey.withOpacity(0.25),
            offset: const Offset(0, 28),
            blurRadius: 40,
            spreadRadius: -4,
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AboutUsIcon(),
          SizedBox(height: 24),
          AboutUsTitle(),
          SizedBox(height: 28),
          Expanded(
            child: AboutUSDescription(),
          ),
        ],
      ),
    );
  }
}

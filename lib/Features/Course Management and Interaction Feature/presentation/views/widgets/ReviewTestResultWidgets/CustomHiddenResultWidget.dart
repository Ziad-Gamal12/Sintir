import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class CustomHiddenResultWidget extends StatelessWidget {
  const CustomHiddenResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          _softBackground(primary),
          Center(child: _content(context, primary, isDark)),
        ],
      ),
    );
  }

  /// -----------------------------------------------------------
  /// BACKGROUND (Premium Soft Glow)
  /// -----------------------------------------------------------
  Widget _softBackground(Color primary) {
    return Stack(
      children: [
        _blurCircle(primary, 240, -80, -40, 0.12),
        _blurCircle(primary, 320, -120, 180, 0.06),
        _blurCircle(primary, 260, 160, -120, 0.10),
      ],
    );
  }

  Widget _blurCircle(
      Color color, double size, double top, double left, double opacity) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withOpacity(opacity),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }

  /// -----------------------------------------------------------
  /// MAIN CONTENT
  /// -----------------------------------------------------------
  Widget _content(BuildContext context, Color primary, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _premiumShieldIcon(primary, isDark),
          const SizedBox(height: 40),
          Text(
            LocaleKeys.resultHiddenByTeacher,
            textAlign: TextAlign.center,
            style: AppTextStyles(context).bold24.copyWith(
                  fontSize: 26,
                  letterSpacing: -0.5,
                  height: 1.1,
                ),
          ),
          const SizedBox(height: 14),
          Text(
            LocaleKeys.resultWillBeShown,
            textAlign: TextAlign.center,
            style: AppTextStyles(context).regular16.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.color
                      ?.withOpacity(0.55),
                  height: 1.6,
                ),
          ),
          const SizedBox(height: 60),
          _footer(primary),
        ],
      ),
    );
  }

  Widget _premiumShieldIcon(Color primary, bool isDark) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Soft Shadow Glow
        Container(
          width: 165,
          height: 165,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                primary.withOpacity(0.10),
                Colors.transparent,
              ],
            ),
          ),
        ),

        // Glass Circle
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isDark ? Colors.white12 : Colors.black12,
              width: 1.3,
            ),
          ),
          child: ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      isDark ? Colors.white12 : Colors.black.withOpacity(0.05),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        // Neumorphic Icon
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: primary.withOpacity(0.15),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                offset: const Offset(0, 8),
                color: primary.withOpacity(0.25),
              ),
            ],
          ),
          child: Icon(
            Icons.privacy_tip_rounded,
            size: 48,
            color: primary,
          ),
        ),
      ],
    );
  }

  Widget _footer(Color primary) {
    return Opacity(
      opacity: 0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _dot(primary),
          const SizedBox(width: 10),
          Text(
            LocaleKeys.secureEncryptedProtected,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 2.8,
              color: primary.withOpacity(0.6),
            ),
          ),
          const SizedBox(width: 10),
          _dot(primary),
        ],
      ),
    );
  }

  Widget _dot(Color c) => Container(
        width: 5,
        height: 5,
        decoration: BoxDecoration(color: c, shape: BoxShape.circle),
      );
}

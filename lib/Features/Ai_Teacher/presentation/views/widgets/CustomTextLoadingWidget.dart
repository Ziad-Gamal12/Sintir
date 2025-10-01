import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomTextLoadingWidget extends StatelessWidget {
  const CustomTextLoadingWidget({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles(context).semiBold20.copyWith(color: Colors.white),
      textAlign: TextAlign.center,
    ).animate().moveY(begin: 20, duration: 800.ms, delay: 800.ms).fadeIn(
          duration: 600.ms,
        );
  }
}

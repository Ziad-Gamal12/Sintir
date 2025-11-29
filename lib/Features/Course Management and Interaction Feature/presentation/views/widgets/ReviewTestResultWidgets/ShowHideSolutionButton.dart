import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class ShowHideSolutionButton extends StatelessWidget {
  const ShowHideSolutionButton({
    super.key,
    required this.isVisible,
    required this.onTap,
  });

  final bool isVisible;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.85),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: KMainColor, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isVisible
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
                color: KMainColor,
                size: 22,
              ),
              Text(
                isVisible ? LocaleKeys.showSolution : LocaleKeys.hideSolution,
                style: AppTextStyles(context)
                    .regular14
                    .copyWith(color: KMainColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

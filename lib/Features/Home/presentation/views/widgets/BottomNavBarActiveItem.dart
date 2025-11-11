import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Home/Domain/Entities/BottomNavBarEntity.dart';
import 'package:sintir/constant.dart';
import 'package:svg_flutter/svg_flutter.dart';

class BottomNavBarActiveItem extends StatelessWidget {
  const BottomNavBarActiveItem({super.key, required this.bottomNavBarEntity});
  final BottomNavBarEntity bottomNavBarEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              color: KMainColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  bottomNavBarEntity.activeIcon,
                  color: KMainColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  bottomNavBarEntity.title,
                  style: AppTextStyles(context)
                      .regular16
                      .copyWith(color: KMainColor),
                )
              ],
            ))
        .animate()
        .fadeIn(
          delay: 100.ms,
          duration: 600.ms,
        )
        .moveY(
          begin: 20,
          duration: 400.ms,
        );
  }
}

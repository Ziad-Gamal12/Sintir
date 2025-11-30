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
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: KMainColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  bottomNavBarEntity.activeIcon,
                  color: const Color.fromARGB(255, 0, 48, 190),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    bottomNavBarEntity.title,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles(context)
                        .regular16
                        .copyWith(color: const Color.fromARGB(255, 0, 48, 190)),
                  ),
                )
              ],
            ))
        .animate()
        .fadeIn(
          delay: 100.ms,
          duration: 400.ms,
        )
        .moveY(
          begin: 10,
          duration: 200.ms,
        );
  }
}

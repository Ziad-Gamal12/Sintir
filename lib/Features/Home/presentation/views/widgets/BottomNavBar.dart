import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Home/Domain/Entities/BottomNavBarEntity.dart';
import 'package:sintir/constant.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, required this.onTabChange});
  final ValueChanged<int> onTabChange;
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 12,
            offset: Offset(0, -3),
          )
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: GNav(
        haptic: true,
        onTabChange: (value) {
          widget.onTabChange(value);
        },

        // Modern rounded tabs
        tabBorderRadius: 20,

        // Smooth, elegant highlight border
        tabActiveBorder: Border.all(
          color: KMainColor.withOpacity(0.4),
          width: 1,
        ),
        tabBorder: Border.all(
          color: Colors.grey.withOpacity(0.3),
          width: 1,
        ),

        curve: Curves.easeOutCubic,
        duration: const Duration(milliseconds: 550),

        gap: 6,

        color: Colors.grey[600],
        activeColor: KMainColor,

        iconSize: 20,

        tabBackgroundColor: KMainColor.withOpacity(0.12),

        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

        tabs: BottomNavBarEntity.toList()
            .map(
              (e) => GButton(
                icon: e.icon,
                text: e.title,
                iconColor: Colors.black,
                textStyle: AppTextStyles(context).regular13.copyWith(
                      color: Colors.black,
                    ),
              ),
            )
            .toList(),
      ),
    );
  }
}

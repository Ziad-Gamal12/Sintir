import 'package:flutter/material.dart';
import 'package:sintir/Features/Home/Domain/Entities/BottomNavBarEntity.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/BottomNavBarItem.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, required this.onTabChange});
  final ValueChanged<int> onTabChange;
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
              BottomNavBarEntity.toList().length,
              (index) => Expanded(
                    flex: currentIndex == index ? 3 : 2,
                    child: InkWell(
                        onTap: () {
                          currentIndex = index;
                          setState(() {});
                          widget.onTabChange(index);
                        },
                        child: BottomNavBarItem(
                          isSelected: currentIndex == index,
                          bottomNavBarEntity:
                              BottomNavBarEntity.toList()[index],
                        )),
                  )),
        ));
  }
}

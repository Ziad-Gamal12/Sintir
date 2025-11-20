import 'package:flutter/material.dart';
import 'package:sintir/Features/Home/Domain/Entities/BottomNavBarEntity.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/BottomNavBarItem.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
    required this.onPageChanged,
  });

  final ValueChanged<int> onPageChanged;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final items = BottomNavBarEntity.toList();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Row(
        children: List.generate(items.length, (index) {
          final isSelected = index == currentIndex;
          return Expanded(
            flex: isSelected ? 3 : 2,
            child: InkWell(
              onTap: () {
                widget.onPageChanged(index);
                setState(() {
                  currentIndex = index;
                });
              },
              child: BottomNavBarItem(
                isSelected: isSelected,
                bottomNavBarEntity: items[index],
              ),
            ),
          );
        }),
      ),
    );
  }
}

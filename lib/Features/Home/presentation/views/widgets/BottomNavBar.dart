import 'package:flutter/material.dart';
import 'package:sintir/Features/Home/Domain/Entities/BottomNavBarEntity.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/BottomNavBarItem.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  /// To avoid multiple listeners being added
  late final VoidCallback _pageListener;

  @override
  void initState() {
    super.initState();

    _pageListener = () {
      final page = widget.pageController.page;

      if (page == null) return;

      final newIndex = page.round();

      if (newIndex != currentIndex) {
        setState(() => currentIndex = newIndex);
      }
    };

    widget.pageController.addListener(_pageListener);
  }

  @override
  void dispose() {
    widget.pageController.removeListener(_pageListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = BottomNavBarEntity.toList();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, -3),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(items.length, (index) {
          final isSelected = index == currentIndex;

          return Expanded(
            flex: isSelected ? 3 : 2,
            child: InkWell(
              onTap: () {
                widget.pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
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

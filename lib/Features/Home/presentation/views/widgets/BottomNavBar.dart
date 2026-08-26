import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Features/Home/Domain/Entities/BottomNavBarEntity.dart';
import 'package:sintir/Features/Home/presentation/manager/cubit/bottom_nav_cubit.dart';
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
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color:
            theme.bottomNavigationBarTheme.backgroundColor ?? theme.cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.brightness == Brightness.light
                ? Colors.black.withValues(alpha: 0.05)
                : Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
          ),
        ],
      ),
      child: BlocBuilder<BottomNavCubit, BottomNavState>(
        builder: (context, state) {
          currentIndex =
              context.read<BottomNavCubit>().state is BottomNavChanged
                  ? (context.read<BottomNavCubit>()).currentIndex
                  : 0;
          return Row(
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
          );
        },
      ),
    );
  }
}

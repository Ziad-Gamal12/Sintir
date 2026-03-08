import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';

class QuickPickSelector extends StatelessWidget {
  final int currentValue;
  final List<int> options;
  final Function(int) onSelected;

  const QuickPickSelector({
    super.key,
    required this.currentValue,
    required this.options,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: options.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final int count = options[index];
          final bool isSelected = currentValue == count;

          return GestureDetector(
            onTap: () => onSelected(count),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? KMainColor
                    : (isDarkMode
                        ? Colors.white.withOpacity(0.05)
                        : Colors.grey.shade100),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected
                      ? KMainColor
                      : (isDarkMode ? Colors.white10 : Colors.grey.shade300),
                  width: 1.5,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: KMainColor.withOpacity(isDarkMode ? 0.3 : 0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ]
                    : [],
              ),
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: AppTextStyles(context).bold14.copyWith(
                      color: isSelected
                          ? Colors.white
                          : (isDarkMode ? Colors.white70 : Colors.black87),
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                child: Text("$count"),
              ),
            ),
          );
        },
      ),
    );
  }
}

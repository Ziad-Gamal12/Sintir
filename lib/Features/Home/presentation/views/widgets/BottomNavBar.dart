// ignore_for_file: file_names

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Features/Home/Domain/Entities/BottomNavBarEntity.dart';
import 'package:sintir/Features/Home/presentation/manager/cubit/bottom_nav_cubit.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/BottomNavBarItem.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.onPageChanged});

  final ValueChanged<int> onPageChanged;

  static const double _maxWidth = 480;
  static const double _innerHeight = 52;
  static const double _barPadding = 8;
  static const double _radius = (_innerHeight + _barPadding * 2) / 2;

  void _handleTap(int index, int currentIndex) {
    if (index == currentIndex) return;
    HapticFeedback.selectionClick();
    onPageChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final items = BottomNavBarEntity.toList();

    final currentIndex = context.select((BottomNavCubit c) => c.currentIndex);

    final viewPadding = MediaQuery.viewPaddingOf(context);
    final surface =
        theme.bottomNavigationBarTheme.backgroundColor ?? theme.cardColor;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        16 + viewPadding.left,
        0,
        16 + viewPadding.right,
        math.max(4.0, viewPadding.bottom - 12),
      ),
      child: Align(
        heightFactor: 1,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _maxWidth),
          child: MediaQuery.withClampedTextScaling(
            maxScaleFactor: 1.15,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: surface,
                borderRadius: BorderRadius.circular(_radius),
                border: Border.all(
                  color: theme.colorScheme.onSurface.withValues(
                    alpha: isDark ? 0.08 : 0.05,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(_barPadding),
                child: SizedBox(
                  height: _innerHeight,
                  child: Row(
                    children: [
                      for (var i = 0; i < items.length; i++)
                        BottomNavBarItem(
                          bottomNavBarEntity: items[i],
                          isSelected: i == currentIndex,
                          onTap: () => _handleTap(i, currentIndex),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

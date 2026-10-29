// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Home/Domain/Entities/BottomNavBarEntity.dart';
import 'package:sintir/constant.dart';
import 'package:svg_flutter/svg_flutter.dart';

class BottomNavBarItem extends StatelessWidget {
  const BottomNavBarItem({
    super.key,
    required this.bottomNavBarEntity,
    required this.isSelected,
    required this.onTap,
  });

  final BottomNavBarEntity bottomNavBarEntity;
  final bool isSelected;
  final VoidCallback onTap;

  static const Duration _duration = Duration(milliseconds: 380);
  static const double _iconSize = 26;
  static const double _gap = 8;
  static const double _pillRadius = 26;

  static const double _baseFlex = 1000;
  static const double _extraFlex = 1300;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final onMain =
        ThemeData.estimateBrightnessForColor(KMainColor) == Brightness.dark
            ? Colors.white
            : Colors.black87;
    final idleColor = theme.colorScheme.onSurface.withValues(alpha: 0.55);

    final hsl = HSLColor.fromColor(KMainColor);
    final lightMain =
        hsl.withLightness((hsl.lightness + 0.08).clamp(0.0, 1.0)).toColor();

    final labelStyle = AppTextStyles(context).regular16.copyWith(
          fontWeight: FontWeight.w600,
          height: 1.1,
        );

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(end: isSelected ? 1.0 : 0.0),
      duration: _duration,
      curve: Curves.easeOutCubic,
      builder: (context, t, _) {
        return Expanded(
          flex: (_baseFlex + _extraFlex * t).round(),
          child: Semantics(
            button: true,
            selected: isSelected,
            label: bottomNavBarEntity.title,
            onTap: onTap,
            excludeSemantics: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: onTap,
                  customBorder: const StadiumBorder(),
                  splashColor: KMainColor.withValues(alpha: 0.12),
                  highlightColor: Colors.transparent,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(_pillRadius),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          lightMain.withValues(alpha: t),
                          KMainColor.withValues(alpha: t),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: KMainColor.withValues(alpha: 0.28 * t),
                          blurRadius: 10,
                          spreadRadius: -1,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Transform.scale(
                              scale: 1 + 0.08 * t,
                              child: _Icon(
                                inactiveAsset: bottomNavBarEntity.inactiveIcon,
                                activeAsset: bottomNavBarEntity.activeIcon,
                                inactiveColor: idleColor.withValues(
                                  alpha: idleColor.a * (1 - t),
                                ),
                                activeColor: onMain.withValues(alpha: t),
                                size: _iconSize,
                              ),
                            ),
                            if (t > 0.01)
                              Flexible(
                                child: ClipRect(
                                  child: Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    widthFactor: t,
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                        start: _gap,
                                      ),
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          bottomNavBarEntity.title,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: labelStyle.copyWith(
                                            color: onMain.withValues(alpha: t),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Icon extends StatelessWidget {
  const _Icon({
    required this.inactiveAsset,
    required this.activeAsset,
    required this.inactiveColor,
    required this.activeColor,
    required this.size,
  });

  final String inactiveAsset, activeAsset;
  final Color inactiveColor, activeColor;
  final double size;

  Widget _svg(String asset, Color color) => SvgPicture.asset(
        asset,
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _svg(inactiveAsset, inactiveColor),
          _svg(activeAsset, activeColor),
        ],
      ),
    );
  }
}

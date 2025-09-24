import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sintir/constant.dart';

class Customrefreshwidget extends StatelessWidget {
  const Customrefreshwidget(
      {super.key, required this.child, required this.onRefresh});
  final Widget child;
  final Future<void> Function() onRefresh;
  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      color: KMainColor,
      backgroundColor: KSecondaryColor,
      height: 300,
      onRefresh: onRefresh,
      animSpeedFactor: 2,
      showChildOpacityTransition: false,
      child: child,
    );
  }
}

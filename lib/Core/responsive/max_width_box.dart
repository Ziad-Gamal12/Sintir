import 'package:flutter/widgets.dart';
import 'package:sintir/Core/responsive/breakpoints.dart';

class MaxWidthBox extends StatelessWidget {
  const MaxWidthBox({
    super.key,
    required this.child,
    this.maxWidth = ContentWidth.form,
    this.alignment = Alignment.topCenter,
    this.expandHeight = false,
  });

  final Widget child;
  final double maxWidth;
  final AlignmentGeometry alignment;
  final bool expandHeight;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: maxWidth,
          maxWidth: maxWidth,
          minHeight: expandHeight ? double.infinity : 0,
        ),
        child: child,
      ),
    );
  }
}

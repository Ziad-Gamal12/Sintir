import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class DragScrollConfiguration extends StatelessWidget {
  const DragScrollConfiguration({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: PointerDeviceKind.values.toSet(),
      ),
      child: child,
    );
  }
}

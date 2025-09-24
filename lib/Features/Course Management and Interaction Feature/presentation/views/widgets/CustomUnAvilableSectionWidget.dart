import 'package:flutter/material.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/Overlay%20Container%20Widget.dart';

class CustomUnAvailableSectionWidget extends StatelessWidget {
  const CustomUnAvailableSectionWidget({
    super.key,
    required this.isAvailable,
  });

  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !isAvailable,
      child: const Positioned.fill(
        child: OverlayContainer(),
      ),
    );
  }
}

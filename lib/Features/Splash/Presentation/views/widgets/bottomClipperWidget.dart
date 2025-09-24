import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class BottomClipperWidget extends StatelessWidget {
  const BottomClipperWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipPath(
        clipper: WaveClipperTwo(reverse: true, flip: true),
        child: Container(
          height: 100,
          color: Colors.white.withOpacity(0.3), // Semi-transparent wave
        ),
      ),
    );
  }
}

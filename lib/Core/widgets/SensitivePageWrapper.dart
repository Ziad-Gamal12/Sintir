import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:secure_content/secure_content.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';

class SensitivePageWrapper extends StatelessWidget {
  final Widget child;
  const SensitivePageWrapper({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return SecureWidget(
      isSecure: true,
      protectInAppSwitcherMenu: true,
      overlayWidgetBuilder: (ctx) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: const SizedBox.expand(),
      ),
      onScreenshotCaptured: () {
        CustomSnackBar.show(context,
            message: "لا يمكن التصوير", type: SnackType.error);
      },
      onScreenRecordingStart: () {
        CustomSnackBar.show(context,
            message: "لا يمكن التسجيل", type: SnackType.error);
      },
      appSwitcherMenuColor: Colors.black,
      builder: (ctx, onInit, onDispose) {
        onInit();
        return child;
      },
    );
  }
}

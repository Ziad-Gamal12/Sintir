// ignore_for_file: file_names

import 'package:flutter/material.dart';

/// Font size scaled to the screen width.
///
/// The scale grows smoothly with the width and is capped, so text stays
/// readable on small phones and does not balloon on tablets (layouts there are
/// width-constrained anyway).
///   360dp → 0.90 · 412dp → 1.03 · ≥ 460dp → 1.15
double getresposiveTet({required BuildContext context, required double basesize}) {
  return basesize * getFontScaleFactor(context);
}

double getFontScaleFactor(BuildContext context) {
  final double width = MediaQuery.sizeOf(context).width;
  return (width / 400).clamp(0.9, 1.15).toDouble();
}

/// Old step-wise factor (width/400, width/600, width/1000).
/// Kept unchanged for any caller outside the text styles; prefer
/// [getFontScaleFactor] for new code.
double getScaleFactor(BuildContext context) {
  double width = MediaQuery.sizeOf(context).width;
  if (width < 600) {
    return width / 400;
  } else if (width < 900) {
    return width / 600;
  } else {
    return width / 1000;
  }
}

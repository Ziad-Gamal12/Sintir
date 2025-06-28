import 'package:flutter/material.dart';

showCustomBottomSheet(
    {required GlobalKey<ScaffoldState> scaffoldKey,
    required Widget child,
    required BuildContext context}) {
  scaffoldKey.currentState?.showBottomSheet((context) => child);
}

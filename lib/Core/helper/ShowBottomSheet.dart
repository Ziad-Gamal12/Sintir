import 'package:flutter/material.dart';

showCustomBottomSheet(
    {required GlobalKey<ScaffoldState> scaffoldKey,
    required Widget child,
    required BuildContext context}) {
  scaffoldKey.currentState?.showBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.grey)),
      backgroundColor: Colors.white,
      (context) => child);
}

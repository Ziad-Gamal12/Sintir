import 'package:flutter/material.dart';

showCustomBottomSheet(
    {required GlobalKey<ScaffoldState> scaffoldKey,
    required Widget child,
    required BuildContext context}) {
  scaffoldKey.currentState?.showBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.black)),
      backgroundColor: Colors.grey.shade200,
      (context) => child);
}

import 'package:flutter/material.dart';

showCustomBottomSheet({required Widget child, required BuildContext context}) {
  showBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          side: BorderSide(color: Colors.grey)),
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => child);
}

showCustomModalBottomSheet(
    {required Widget child, required BuildContext context}) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          side: BorderSide(color: Colors.grey)),
      backgroundColor: Colors.white,
      builder: (context) => child);
}

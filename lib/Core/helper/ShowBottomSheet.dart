import 'package:flutter/material.dart';

showCustomBottomSheet({required Widget child, required BuildContext context}) {
  showBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.grey)),
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
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.grey)),
      backgroundColor: Colors.white,
      builder: (context) => child);
}

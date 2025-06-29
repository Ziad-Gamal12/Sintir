import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTrashIcon extends StatelessWidget {
  const CustomTrashIcon({
    super.key,
    required this.onpressed,
  });
  final VoidCallback onpressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onpressed,
        icon: const Icon(
          FontAwesomeIcons.trash,
          color: Colors.red,
        ));
  }
}

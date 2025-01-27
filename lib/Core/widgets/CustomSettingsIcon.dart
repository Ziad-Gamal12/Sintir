import 'package:flutter/material.dart';

class Customsettingsicon extends StatelessWidget {
  const Customsettingsicon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: const Icon(
          Icons.settings,
          color: Colors.black,
          size: 24,
        ));
  }
}

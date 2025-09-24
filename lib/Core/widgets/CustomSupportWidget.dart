import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Customsupportwidget extends StatelessWidget {
  const Customsupportwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: const Icon(
        FontAwesomeIcons.circleInfo,
        color: Colors.black,
        size: 24,
      ),
    );
  }
}

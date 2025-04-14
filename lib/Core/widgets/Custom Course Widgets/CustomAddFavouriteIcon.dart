// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAddFavouriteIcon extends StatelessWidget {
  const CustomAddFavouriteIcon({
    super.key,
    required this.ontap,
    required this.isFavourite,
  });
  final VoidCallback ontap;
  final bool isFavourite;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 14,
      backgroundColor: const Color(0xffFFFFFF),
      child: Center(
        child: IconButton(
            onPressed: ontap,
            icon: Icon(
              FontAwesomeIcons.solidHeart,
              color: isFavourite ? Colors.red : Colors.black,
              size: 13,
            )),
      ),
    );
  }
}

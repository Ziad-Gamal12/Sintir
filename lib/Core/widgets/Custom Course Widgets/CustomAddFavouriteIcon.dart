import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAddFavouriteIcon extends StatelessWidget {
  const CustomAddFavouriteIcon({
    super.key,
    required this.ontap,
  });
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 14,
      backgroundColor: const Color(0xffFFFFFF),
      child: Center(
        child: IconButton(
            onPressed: ontap,
            icon: const Icon(
              FontAwesomeIcons.solidHeart,
              size: 13,
            )),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomcoursedetailsOptionitemIcon extends StatelessWidget {
  const CustomcoursedetailsOptionitemIcon({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      color: Colors.black,
      height: 30,
      width: 30,
    );
  }
}

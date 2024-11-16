import 'package:flutter/material.dart';

class CustomContentCreatorCircleAvartar extends StatelessWidget {
  const CustomContentCreatorCircleAvartar({
    super.key,
    required this.imagepath,
  });
  final String imagepath;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(45),
        child: Image.asset(
          imagepath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

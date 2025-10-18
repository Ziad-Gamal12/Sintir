import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';

class StudentAvatar extends StatelessWidget {
  const StudentAvatar({super.key, required this.url});
  final String url;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: CustomCachedNetworkImage(imageUrl: url),
      ),
    );
  }
}

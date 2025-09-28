import 'package:flutter/material.dart';

class UserAvatarChangedPic extends StatelessWidget {
  const UserAvatarChangedPic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: const Icon(
        Icons.camera_alt_outlined,
        size: 20,
      ),
    );
  }
}

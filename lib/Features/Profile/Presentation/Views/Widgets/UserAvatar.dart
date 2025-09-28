import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/UserAvatarChangedPic.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .22,
            child: AspectRatio(
                aspectRatio: 1 / 1,
                child: CustomCachedNetworkImage(imageUrl: imageUrl)),
          ),
        ),
        const Positioned(
          bottom: -15,
          left: 0,
          right: 0,
          child: UserAvatarChangedPic(),
        ),
      ],
    );
  }
}

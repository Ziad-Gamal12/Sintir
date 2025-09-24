import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomAddFavouriteIcon.dart';

class CourseItemFavouriteIcon extends StatelessWidget {
  const CourseItemFavouriteIcon({
    super.key,
    required this.isFavourite,
    required this.onTap,
  });

  final bool isFavourite;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomAddFavouriteIcon(
      isFavourite: isFavourite,
      ontap: onTap,
    );
  }
}

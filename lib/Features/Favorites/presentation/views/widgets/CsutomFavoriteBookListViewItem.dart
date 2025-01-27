import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomAddFavouriteIcon.dart';

class Csutomfavoritebooklistviewitem extends StatelessWidget {
  const Csutomfavoritebooklistviewitem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: const DecorationImage(
              image: AssetImage(Assets.assetsImagesBookImageTest),
              fit: BoxFit.cover),
          border: Border.all(color: Colors.black, width: 1)),
      child: Align(
        alignment: Alignment.topLeft,
        child: CustomAddFavouriteIcon(isFavourite: true, ontap: () {}),
      ),
    );
  }
}

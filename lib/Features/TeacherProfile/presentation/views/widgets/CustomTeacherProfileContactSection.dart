import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Features/TeacherProfile/presentation/views/widgets/customContactItem.dart';

class Customteacherprofilecontactsection extends StatelessWidget {
  const Customteacherprofilecontactsection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Customcontactitem(
              image: Assets.assetsImagesTelephone, title: "0123456789"),
          SizedBox(
            width: 4,
          ),
          Customcontactitem(
              image: Assets.assetsImagesFaceBookIcons,
              title: "https://www.facebook.com/"),
          SizedBox(
            width: 4,
          ),
          Customcontactitem(
              image: Assets.assetsImagesTwitter, title: "https://twitter.com/"),
        ],
      ),
    );
  }
}

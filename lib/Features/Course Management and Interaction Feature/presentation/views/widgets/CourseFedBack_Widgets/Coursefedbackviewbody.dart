import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomChatTextField.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursefedbackItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseFedBack_Widgets/CourseFedBacksListView.dart';
import 'package:sintir/constant.dart';

class Coursefedbackviewbody extends StatefulWidget {
  const Coursefedbackviewbody({super.key});

  @override
  State<Coursefedbackviewbody> createState() => _CoursefedbackviewbodyState();
}

class _CoursefedbackviewbodyState extends State<Coursefedbackviewbody> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
      child: Stack(
        children: [
          Coursefedbackslistview(courseFedBacks: [
            CoursefedbackItemEntity(
                datePosted: DateTime(2024, 6, 10),
                fedBack: "اشكرك على هذا المحتوى",
                likesCount: "24",
                name: "احمد",
                userImage: Assets.assetsImagesUserAvatar),
          ]),
          Positioned(
              bottom: 25,
              left: 0,
              right: 0,
              child: CustomChatTextField(
                  controller: controller,
                  validator: (value) {
                    return null;
                  }))
        ],
      ),
    );
  }
}

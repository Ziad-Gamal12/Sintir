import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomAddFavouriteIcon.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/constant.dart';

class CutomBookDetailsBookACtions extends StatelessWidget {
  const CutomBookDetailsBookACtions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomAddFavouriteIcon(isFavourite: false, ontap: () {}),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Custombutton(
              text: "معاينة الكتاب",
              color: KSecondaryColor,
              textColor: Colors.white,
              onPressed: () {}),
        )
      ],
    );
  }
}

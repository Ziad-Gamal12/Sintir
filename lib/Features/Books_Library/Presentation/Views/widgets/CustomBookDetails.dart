import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomAddFavouriteIcon.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/constant.dart';

class CustomBookDetails extends StatelessWidget {
  const CustomBookDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "الأضواء",
          style: AppTextStyles.semiBold20.copyWith(color: KMainColor),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          "اللغه العربية",
          style: AppTextStyles.regular14.copyWith(color: Colors.black),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "الصف الثالث الأبتدائى",
          style: AppTextStyles.regular14.copyWith(color: Colors.black),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.language,
                  color: Colors.grey,
                  size: 16,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "(ِAr)",
                  style: AppTextStyles.regular10.copyWith(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "(2024/2025)",
              style: AppTextStyles.regular10.copyWith(color: Colors.grey),
            )
          ],
        ),
        const Spacer(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomAddFavouriteIcon(ontap: () {}),
            const SizedBox(
              width: 20,
            ),
            Flexible(
              child: SizedBox(
                width: 156,
                child: Custombutton(
                    text: "معاينة الكتاب",
                    color: KSecondaryColor,
                    textColor: Colors.white,
                    onPressed: () {}),
              ),
            )
          ],
        )
      ],
    );
  }
}

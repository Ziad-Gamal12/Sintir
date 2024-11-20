import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class Customfavoritebookslistviewheader extends StatelessWidget {
  const Customfavoritebookslistviewheader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("كتبي المفضلة",
            style: AppTextStyles.semiBold20.copyWith(color: Colors.black)),
      ],
    );
  }
}

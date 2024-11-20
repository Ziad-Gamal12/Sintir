// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class Customfavoritecoursegrideviewheader extends StatelessWidget {
  const Customfavoritecoursegrideviewheader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("كورساتي المفضلة",
            style: AppTextStyles.semiBold20.copyWith(color: Colors.black)),
      ],
    );
  }
}

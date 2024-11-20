import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Features/Books_Library/Presentation/Views/widgets/CustomBookDetails.dart';

class Bookslistviewitem extends StatelessWidget {
  const Bookslistviewitem({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Image.asset(
              Assets.assetsImagesBookImageTest,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          const Expanded(flex: 3, child: CustomBookDetails())
        ],
      ),
    );
  }
}

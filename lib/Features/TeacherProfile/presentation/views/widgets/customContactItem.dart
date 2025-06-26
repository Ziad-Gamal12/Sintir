// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class Customcontactitem extends StatelessWidget {
  const Customcontactitem(
      {super.key, required this.title, required this.image});
  final String title, image;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CachedNetworkImage(imageUrl: image, height: 13, width: 13),
        const SizedBox(
          width: 4,
        ),
        Text(title,
            style: AppTextStyles.regular10.copyWith(color: Colors.black)),
        IconButton(
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: title)).then(
                  (value) => ShowSnackBar(
                      context: context,
                      child: Text("تم النسخ  بنجاح",
                          style: AppTextStyles.regular14
                              .copyWith(color: Colors.black)),
                      backgroundColor: Colors.grey.shade200));
            },
            icon: const Icon(
              Icons.copy,
              color: Colors.black,
              size: 12,
            ))
      ],
    );
  }
}

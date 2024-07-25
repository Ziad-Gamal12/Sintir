import 'package:flutter/material.dart';

import 'package:sintir/Core/Utils/textStyles.dart';

class CustomAppbar extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  const CustomAppbar({super.key, required this.title, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: width * 0.15, top: 20, bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: onPressed,
            icon: Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.black, size: 20),
          ),
          Text(
            title,
            style: textStyles.textstyle19,
          )
        ],
      ),
    );
  }
}

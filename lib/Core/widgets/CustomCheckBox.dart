// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/constant.dart';
import 'package:svg_flutter/svg.dart';

class Customcheckbox extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  const Customcheckbox({super.key, required this.onChanged});

  @override
  State<Customcheckbox> createState() => _CustomcheckboxState();
}

class _CustomcheckboxState extends State<Customcheckbox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        isChecked = !isChecked;
        setState(() {});
        widget.onChanged(isChecked);
      },
      child: AnimatedContainer(
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 300),
        height: 24,
        width: 24,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 1.50,
                color:
                    isChecked ? Colors.transparent : const Color(0xFFDCDEDE)),
            borderRadius: BorderRadius.circular(8),
          ),
          color: isChecked ? KMainColor : Colors.white,
        ),
        child: isChecked
            ? SvgPicture.asset(
                Assets.assetsImagesCheckedIcon,
              )
            : const SizedBox(),
      ),
    );
  }
}

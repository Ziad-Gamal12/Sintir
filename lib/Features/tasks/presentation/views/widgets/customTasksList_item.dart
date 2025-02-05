// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomtaskslistItem extends StatefulWidget {
  const CustomtaskslistItem({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;

  @override
  State<CustomtaskslistItem> createState() => _CustomtaskslistItemState();
}

class _CustomtaskslistItemState extends State<CustomtaskslistItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 61,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
          title: Text(
            widget.title,
            style: AppTextStyles.regular14.copyWith(color: Colors.black),
            textAlign: TextAlign.right,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            widget.subtitle,
            style: AppTextStyles.regular10
                .copyWith(color: const Color(0xff818181)),
            textAlign: TextAlign.right,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: InkWell(
            onTap: () {
              isSelected = !isSelected;
              setState(() {});
            },
            child: Container(
                alignment: Alignment.center,
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: isSelected == true
                      ? Colors.green
                      : const Color(0xffD9D9D9),
                ),
                child: isSelected == true
                    ? const Icon(
                        Icons.check,
                        size: 15,
                        color: Colors.white,
                      )
                    : const SizedBox()),
          )),
    );
  }
}

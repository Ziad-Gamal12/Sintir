import 'package:flutter/material.dart';
import 'package:sintir/constant.dart';

class AddCourseSectionSqlTestAddQuestionsActionbutton extends StatelessWidget {
  const AddCourseSectionSqlTestAddQuestionsActionbutton({
    super.key,
    required this.onPressed,
  });
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 40,
        right: 0,
        left: 0,
        child: InkWell(
          onTap: onPressed,
          child: const CircleAvatar(
            radius: 35,
            backgroundColor: KSecondaryColor,
            child: Icon(Icons.add, color: Colors.white),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/customSolutionStateCheckBoxWidget.dart';

class CustomSolutionStateRowWidget extends StatelessWidget {
  const CustomSolutionStateRowWidget(
      {super.key, required this.isCorrect, required this.title});
  final bool isCorrect;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Customsolutionstatecheckboxwidget(
        isCorrect: isCorrect,
      ),
      const SizedBox(
        width: 5,
      ),
      Text(
        title,
        style: AppTextStyles(context).semiBold16.copyWith(color: Colors.black),
      )
    ]);
  }
}

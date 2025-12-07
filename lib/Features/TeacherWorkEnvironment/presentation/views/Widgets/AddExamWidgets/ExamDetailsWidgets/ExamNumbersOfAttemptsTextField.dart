import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/locale_keys.dart';

class ExamNumbersOfAttemptsTextField extends StatefulWidget {
  const ExamNumbersOfAttemptsTextField(
      {super.key, required this.coursetestentity});
  final CourseTestEntity coursetestentity;

  @override
  State<ExamNumbersOfAttemptsTextField> createState() =>
      _ExamNumbersOfAttemptsTextFieldState();
}

class _ExamNumbersOfAttemptsTextFieldState
    extends State<ExamNumbersOfAttemptsTextField> {
  late TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
        text: widget.coursetestentity.numberOfAttempts == null
            ? ""
            : widget.coursetestentity.numberOfAttempts.toString());
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        hintText: LocaleKeys.examAttemptsCount,
        controller: controller,
        obscureText: false,
        textInputType: TextInputType.number,
        prefixIcon: Icons.numbers,
        onSaved: (val) {
          if (val != null && val.isNotEmpty) {
            {
              widget.coursetestentity.numberOfAttempts = int.tryParse(val);
            }
          }
        },
        validator: (val) {
          return null;
        });
  }
}

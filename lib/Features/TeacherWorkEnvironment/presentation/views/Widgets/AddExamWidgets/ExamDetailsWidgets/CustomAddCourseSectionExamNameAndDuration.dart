import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/locale_keys.dart';

class CustomAddCourseSectionExamNameAndDuration extends StatefulWidget {
  const CustomAddCourseSectionExamNameAndDuration({
    super.key,
    required this.coursetestentity,
  });
  final CourseTestEntity coursetestentity;

  @override
  State<CustomAddCourseSectionExamNameAndDuration> createState() =>
      _CustomAddCourseSectionExamNameAndDurationState();
}

class _CustomAddCourseSectionExamNameAndDurationState
    extends State<CustomAddCourseSectionExamNameAndDuration> {
  late TextEditingController titleController;
  late TextEditingController durationController;
  @override
  void initState() {
    super.initState();
    titleController =
        TextEditingController(text: widget.coursetestentity.title);
    durationController = TextEditingController(
        text: widget.coursetestentity.durationTime.toString());
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    durationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
            controller: titleController,
            hintText: LocaleKeys.examName,
            obscureText: false,
            onSaved: (value) {
              widget.coursetestentity.title = value!;
            },
            textInputType: TextInputType.text,
            prefixIcon: Icons.text_snippet_outlined,
            validator: (value) {
              if (value!.isEmpty) {
                return LocaleKeys.enterExamName;
              }
              return null;
            }),
        const SizedBox(
          height: 20,
        ),
        CustomTextField(
            controller: durationController,
            onSaved: (value) {
              widget.coursetestentity.durationTime = int.tryParse(value!) ?? 0;
            },
            hintText: LocaleKeys.examDuration,
            obscureText: false,
            textInputType: TextInputType.number,
            prefixIcon: Icons.timer_outlined,
            validator: (value) {
              if (value!.isEmpty) {
                return LocaleKeys.enterDuration;
              }
              return null;
            })
      ],
    );
  }
}

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
        text: widget.coursetestentity.durationTime == 0
            ? ""
            : widget.coursetestentity.durationTime.toString());
  }

  @override
  void dispose() {
    titleController.dispose();
    durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          controller: titleController,
          hintText: LocaleKeys.examName,
          obscureText: false,
          onSaved: (value) => widget.coursetestentity.title = value!,
          textInputType: TextInputType.text,
          prefixIcon: Icons.assignment_rounded,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return LocaleKeys.enterExamName;
            }
            return null;
          },
        ),
        const SizedBox(height: 24),

        // Premium Duration Field
        CustomTextField(
          controller: durationController,
          hintText: LocaleKeys.examDuration,
          obscureText: false,
          textInputType: TextInputType.number,
          onSaved: (value) =>
              widget.coursetestentity.durationTime = int.tryParse(value!) ?? 0,
          prefixIcon: Icons.av_timer_rounded,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return LocaleKeys.enterDuration;
            }
            return null;
          },
        ),
      ],
    );
  }
}

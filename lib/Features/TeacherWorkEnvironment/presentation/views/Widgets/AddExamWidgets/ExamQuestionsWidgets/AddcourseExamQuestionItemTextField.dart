import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/locale_keys.dart';

/// The question text. It writes every edit straight to the question, so the
/// text survives the field being rebuilt, e.g. after visiting the review step.
class AddcourseExamQuestionItemTextField extends StatefulWidget {
  const AddcourseExamQuestionItemTextField({
    super.key,
    required this.coursetestquestionentity,
  });

  final CourseTestQuestionEntity coursetestquestionentity;

  @override
  State<AddcourseExamQuestionItemTextField> createState() =>
      _AddcourseExamQuestionItemTextFieldState();
}

class _AddcourseExamQuestionItemTextFieldState
    extends State<AddcourseExamQuestionItemTextField> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.coursetestquestionentity.questionTitle ?? '',
  )..addListener(_writeToQuestion);

  void _writeToQuestion() {
    widget.coursetestquestionentity.questionTitle = _controller.text;
  }

  @override
  void didUpdateWidget(AddcourseExamQuestionItemTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final question = widget.coursetestquestionentity;
    if (!identical(question, oldWidget.coursetestquestionentity)) {
      _controller.text = question.questionTitle ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: _controller,
      hintText: LocaleKeys.enterQuestionHere,
      obscureText: false,
      textInputType: TextInputType.text,
      minLines: 1,
      maxLines: 4,
      validator: (value) => null,
    );
  }
}

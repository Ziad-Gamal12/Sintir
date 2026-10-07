import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/controllers/add_video_form_controller.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/widgets/form/discard_text_button.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/widgets/form/submit_video_button.dart';

class AddVideoBottomBar extends StatelessWidget {
  const AddVideoBottomBar({
    super.key,
    required this.form,
    required this.onSubmit,
    required this.onDiscard,
  });

  final AddVideoFormController form;
  final VoidCallback onSubmit;
  final VoidCallback onDiscard;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SubmitVideoButton(form: form, onSubmit: onSubmit),
            DiscardTextButton(onPressed: onDiscard),
          ],
        ),
      ),
    );
  }
}

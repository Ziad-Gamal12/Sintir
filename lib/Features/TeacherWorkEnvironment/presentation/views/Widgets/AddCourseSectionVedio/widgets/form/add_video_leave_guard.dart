import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/controllers/add_video_form_controller.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/logic/add_video_phase.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/logic/leave_add_video_screen.dart';

/// Intercepts system back/gesture while there is unsaved input or an upload
/// in flight. [child] is built once and never rebuilt by the guard.
class AddVideoLeaveGuard extends StatelessWidget {
  const AddVideoLeaveGuard({
    super.key,
    required this.form,
    required this.child,
  });

  final AddVideoFormController form;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AddVideoPhaseBuilder(
      builder: (context, phase) => ListenableBuilder(
        listenable: form.changes,
        child: child,
        builder: (context, child) => PopScope<Object?>(
          canPop: !form.isDirty && !phase.isBusy,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) leaveAddVideoScreen(context, form);
          },
          child: child!,
        ),
      ),
    );
  }
}

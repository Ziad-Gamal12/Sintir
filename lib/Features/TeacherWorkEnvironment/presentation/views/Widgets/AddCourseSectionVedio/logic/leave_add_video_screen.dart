import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Managers/Cubits/video_item_cubit/video_item_cubit.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/controllers/add_video_form_controller.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/logic/add_video_phase.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/logic/discard_video_dialog.dart';

/// Leaves the screen, asking first when there is unsaved input or work in
/// progress. Confirming while an upload runs cancels that upload.
Future<void> leaveAddVideoScreen(
  BuildContext context,
  AddVideoFormController form,
) async {
  final phase = AddVideoPhase.read(context);
  if (!form.isDirty && !phase.isBusy) {
    context.pop();
    return;
  }

  if (form.isLeaveDialogOpen) return;
  form.isLeaveDialogOpen = true;
  final shouldDiscard = await showDiscardVideoDialog(context);
  form.isLeaveDialogOpen = false;
  if (!shouldDiscard || !context.mounted) return;

  if (AddVideoPhase.read(context) == AddVideoPhase.uploading) {
    await context.read<VideoItemCubit>().cancelVideoUpload();
  }
  if (context.mounted) context.pop();
}

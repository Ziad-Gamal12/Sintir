import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/video_item_cubit/video_item_cubit.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/controllers/add_video_form_controller.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/logic/add_video_phase.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/utils/add_video_dimens.dart';
import 'package:sintir/locale_keys.dart';

class SubmitVideoButton extends StatelessWidget {
  const SubmitVideoButton({
    super.key,
    required this.form,
    required this.onSubmit,
  });

  final AddVideoFormController form;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return AddVideoPhaseBuilder(
      builder: (context, phase) => ListenableBuilder(
        listenable: form.changes,
        builder: (context, _) => FilledButton.icon(
          onPressed: !phase.isBusy && form.canSubmit ? onSubmit : null,
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(54),
            disabledBackgroundColor: colors.primary.withValues(alpha: .42),
            disabledForegroundColor: colors.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AddVideoDimens.radius),
            ),
          ),
          icon: phase.isBusy
              ? SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: colors.onPrimary,
                  ),
                )
              : const Icon(Icons.cloud_upload_outlined, color: Colors.white),
          label: _SubmitButtonLabel(phase: phase),
        ),
      ),
    );
  }
}

class _SubmitButtonLabel extends StatelessWidget {
  const _SubmitButtonLabel({required this.phase});

  final AddVideoPhase phase;

  @override
  Widget build(BuildContext context) {
    final style =
        AppTextStyles(context).semiBold16.copyWith(color: Colors.white);

    return switch (phase) {
      AddVideoPhase.uploading =>
        BlocSelector<VideoItemCubit, VideoItemState, int>(
          selector: (state) => state is UploadVideoLoading
              ? (state.progress.clamp(0, 1) * 100).round()
              : 0,
          builder: (context, percent) => Text(
            LocaleKeys.uploadingVideoButton(percent),
            textAlign: TextAlign.center,
            style: style,
          ),
        ),
      AddVideoPhase.saving =>
        Text(LocaleKeys.savingVideo, textAlign: TextAlign.center, style: style),
      AddVideoPhase.failed =>
        Text(LocaleKeys.retryUpload, textAlign: TextAlign.center, style: style),
      AddVideoPhase.idle => Text(
          LocaleKeys.uploadAndSaveVideo,
          textAlign: TextAlign.center,
          style: style,
        ),
    };
  }
}

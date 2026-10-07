import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/video_item_cubit/video_item_cubit.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/controllers/add_video_form_controller.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/controllers/video_preview_controller.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/logic/add_video_phase.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/widgets/picker/empty_video_picker_card.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/widgets/picker/selected_video_card.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/widgets/picker/upload_progress_section.dart';

class VideoPickerSection extends StatelessWidget {
  const VideoPickerSection({super.key, required this.form});

  final AddVideoFormController form;

  static const _animation = Duration(milliseconds: 220);

  void _pick(BuildContext context) {
    context
        .read<VideoItemCubit>()
        .pickVideoFile(coursevedioitementity: form.video);
  }

  void _remove(BuildContext context) {
    form.clearFile();
    context.read<VideoItemCubit>().clearSelectedVideo();
  }

  @override
  Widget build(BuildContext context) {
    return AddVideoPhaseBuilder(
      builder: (context, phase) =>
          ValueListenableBuilder<VideoPreviewController?>(
        valueListenable: form.preview,
        builder: (context, preview, _) => AnimatedSize(
          duration: _animation,
          alignment: Alignment.topCenter,
          child: AnimatedSwitcher(
            duration: _animation,
            child: switch ((phase, preview)) {
              (AddVideoPhase.uploading, _) =>
                const UploadProgressSection(key: ValueKey('uploading')),
              (_, null) => EmptyVideoPickerCard(
                  key: const ValueKey('empty'),
                  onPick: () => _pick(context),
                ),
              (_, final selected?) => SelectedVideoCard(
                  key: const ValueKey('selected'),
                  preview: selected,
                  enabled: !phase.isBusy,
                  onChange: () => _pick(context),
                  onRemove: () => _remove(context),
                ),
            },
          ),
        ),
      ),
    );
  }
}
